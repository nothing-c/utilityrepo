package main;

import(
	"fmt"
	"net/http"
	"io/ioutil"
	"regexp"
	"os"
	"sync"
)

/*
NOTE: IF THE REGEX GOES FUNKY AGAIN, JUST TRY OVER LMAO
After some testing, it looks like the regex failures are just random or smth
*/
func imgget(url string, i int, imgreg string, mainwg * sync.WaitGroup)(){
	//have to pass by pointer so we keep the count right
	thirdpull, err := http.Get(url);
	if err != nil {
		fmt.Println("bruh moment");
	} else {
		thirdbody, err := ioutil.ReadAll(thirdpull.Body);
		thirdpull.Body.Close();
		if err != nil {
			fmt.Println(err);
		} else {
			ioutil.WriteFile(imgreg, []byte(thirdbody), 0666);
		}
	}
	//decrement active goroutine counter by one at end of func
	mainwg.Done();

}

func main(){
	link := os.Args[1];
	//this regex may not be up-to-date forever
	matcher, _ := regexp.Compile("https://wallhaven.cc/w/.{6}");
	imgmatch, _ := regexp.Compile("https://w.wallhaven.cc/full/.*/.*.(jpg|png)")
	imgname, _ := regexp.Compile(".{6}.jpg");
	pull, err := http.Get(link);
	if err != nil {
		fmt.Println(err);
	}
	//this allow the prog to wait for all goroutines to finish before close
	mainwg := new(sync.WaitGroup);
	//need this for regex
	pulled, _ := ioutil.ReadAll(pull.Body);
	pull.Body.Close();
	//this should give me a slice or array or smth
	matched := make([]string, 0);
	matched = append(matcher.FindAllString(string(pulled),-1));
	fmt.Println(matched);
	//link is assigned matched[i]
	for i, link := range matched {
		//Add to num of active goroutines
		mainwg.Add(1);
		secpull, err := http.Get(link);
		if err != nil {
			fmt.Println(err);
		} else {
			body, err := ioutil.ReadAll(secpull.Body);
			if err != nil {
				fmt.Println(err);
			} else {
				fmt.Println(link);
				lasturl := string(imgmatch.Find(body));
				if lasturl == "" {
					fmt.Println("regex broke ):");
				}
				name := imgname.FindString(lasturl);
				go imgget(lasturl,i,name,mainwg);
				secpull.Body.Close();
			}
		}
	}
	//wait for goroutines to finish
	mainwg.Wait();
	fmt.Println("closing up shop!");
}


