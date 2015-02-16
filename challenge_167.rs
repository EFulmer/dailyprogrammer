// challenge_167.rs

use std::old_io as io;

fn main() {
    let mut stdin = io::stdin();

    println!("Enter your paragraph:");

    let para = stdin.read_line()
        .ok()
        .expect("error reading from stdin")
        .trim()
        .to_string();

    let mut html_out = io::File::create(&Path::new("challenge_167_output.html"))
        .ok()
        .expect("bad path"); 

    write!(&mut html_out, 
    "<!DOCTYPE html>
    <html>
        <head>
            <title></title>
        </head>

        <body>
            <p>{}</p>
        </body>
    </html>", 
    para);
}
