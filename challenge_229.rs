use std::f64;

const EPSILON: f64 = 0.00000000000001;

fn dottie(x: f64) -> f64 {
    let mut i1 = x.cos();
    let mut i2 = x;

    while (i1 - i2).abs() > EPSILON {
        i2 = i1;
        i1 = i1.cos();
    }

    i1
}

fn dottie_rec(x: f64) -> f64 {
    if (x - x.cos()).abs() < EPSILON {
        x
    } else {
        dottie_rec(x.cos())
    }
}

fn fix(f: fn(f64) -> f64, x: f64) -> f64 {
    if (x - f(x)).abs() < EPSILON {
        x
    }
    else {
        fix(f, f(x))
    }
}

fn main() {
    println!("{}", dottie(10 as f64));
    println!("{}", dottie_rec(10 as f64));
    println!("{}", fix(f64::cos, 10 as f64));
}
