To: linuxppc-dev@lists.linuxppc.org
Subject: Re: xf 4.0.0/1 with rage II/rage pro -- should the ati driver work?
In-Reply-To: <39D4B5FB.F2F88B00@student.ethz.ch>
References: <39D47072.2CC1E9A6@student.ethz.ch>
	<20000930002437Z.kohkichi@venus.dti.ne.jp>
	<39D4B5FB.F2F88B00@student.ethz.ch>
From: Kohkichi Hosoda <khosoda@venus.dti.ne.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Message-Id: <20000930152126S.kohkichi@venus.dti.ne.jp>
Date: Sat, 30 Sep 2000 15:21:26 +0900
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>> I tried your binary with ati driver from
>> penguinppc.org::xfree86-pmac on iMac revB.  It worked for
>> 15 bit color but did not used to work for 24 bit color.
>> After installation of your binary, it works well!!

Michel> That's great! How did it fail before?

Well, I'm confused.  When I tried 24 bit color with default
fbdev and ati a week ago, it did not work.  Now, however, it
works well although it is slower than 24 bit color with your
binary.

Result of x11perf --scroll500 with default fbdev and ati;

Sync time adjustment is 0.1741 msecs.

    200 reps @  26.9526 msec (    37.1/sec): Scroll 500x500 pixels
    200 reps @  27.0679 msec (    36.9/sec): Scroll 500x500 pixels
    200 reps @  27.0197 msec (    37.0/sec): Scroll 500x500 pixels
    200 reps @  27.1500 msec (    36.8/sec): Scroll 500x500 pixels
    200 reps @  26.9818 msec (    37.1/sec): Scroll 500x500 pixels
   1000 trep @  27.0344 msec (    37.0/sec): Scroll 500x500 pixels

With yur binary, it is around 1.5 times faster, as described
in the previous mail.

It's weird, but I can't figure out why default fbdev started
to work with 24 bit color again.  According to my poor
memory, XFree86.0.log used to show "Fatal server error:
failed to initialize core devices" in the last part,
although I'm not sure.

Anyway, thanks a lot for providing a better driver.

Kohkichi Hosoda

E-mail address: khosoda@venus.dti.ne.jp

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
