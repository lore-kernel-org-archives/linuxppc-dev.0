To: daenzerm@student.ethz.ch
Cc: costabel@wanadoo.fr, mlan@cpu.lu, linuxppc-dev@lists.linuxppc.org
Subject: Re: xf 4.0.0/1 with rage II/rage pro -- should the ati driver work?
From: Kohkichi Hosoda <khosoda@venus.dti.ne.jp>
In-Reply-To: <39D47072.2CC1E9A6@student.ethz.ch>
References: <39CE25AF.E29D265F@wanadoo.fr>
	<39CE286A.E63425A6@student.ethz.ch>
	<39D47072.2CC1E9A6@student.ethz.ch>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Message-Id: <20000930002437Z.kohkichi@venus.dti.ne.jp>
Date: Sat, 30 Sep 2000 00:24:37 +0900
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>>>> On Fri, 29 Sep 2000 12:35:30 +0200, Michel Dänzer <daenzerm@student.ethz.ch> said:

>> http://n.ethz.ch/student/daenzerm/download/X4-fbdev-test.tar.bz2
>>
>> Beware: DON'T use this with an accelerated driver right
>> now.

Michel> This warning should be obsolete now, I've updated the tarball

I tried your binary with ati driver from
penguinppc.org::xfree86-pmac on iMac revB.  It worked for 15
bit color but did not used to work for 24 bit color.  After
installation of your binary, it works well!!

Result of x11perf --scroll500 under your binary + ati driver;

Sync time adjustment is 0.2300 msecs.

    300 reps @  19.5974 msec (    51.0/sec): Scroll 500x500 pixels
    300 reps @  19.4797 msec (    51.3/sec): Scroll 500x500 pixels
    300 reps @  19.3297 msec (    51.7/sec): Scroll 500x500 pixels
    300 reps @  19.3649 msec (    51.6/sec): Scroll 500x500 pixels
    300 reps @  19.1724 msec (    52.2/sec): Scroll 500x500 pixels
   1500 trep @  19.3888 msec (    51.6/sec): Scroll 500x500 pixels

I know this is not so fast especially for r128 people, but
for me this is great improvement.

Thanks a lot.

Kohkichi Hosoda

E-mail address: khosoda@venus.dti.ne.jp


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
