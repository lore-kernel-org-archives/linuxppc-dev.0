Message-ID: <3926A313.3AB13BBA@wibble.net>
Date: Sun, 21 May 2000 00:37:07 +1000
From: Steven Hanley <sjh@wibble.net>
MIME-Version: 1.0
To: Ethan Benson <erbenson@alaska.net>,
        Linux PPC Dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Paul's 2.2.15 does not boot a 7200
References: <20000520002947.A6452@plato.local.lan>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Ethan

I think it may actually be booting, if it is hooked up to a netwrok try
pinging it or sshing into it, I also had this problem with the 2.2.14
pre series from linuxcare on my 7200/200 with a normal atyfb, the
problem was the thing's video was blank after the bootx sequence
finished loding it and the kernal ran. 2.2.10 was fine so I wanted to
know what the problem with the graphics was/is, it seems some change in
2.2.* recently made it detect the graphics capabilities incorectly and
not use the right mode.

so the fix is to put something like video=atyfb:vmode:5 on the kernel
command line and it will boot with text displauyed, I still am somewhat
annmoyed as 2.2.10 the thing auto detected and displayed 100x40 or osme
similarly sized mode, and now it only does 80x50, which I find way too
large (even on the 14" monitor I have with this machine (heck I happily
run 160x60 console on 15" monitors on my x86 boxen)

Anyway try forcing a specific video mode ont he kernel command line and
you may get a display. I was able to work with the machine with no
display quite happily using only ssh and such and was thus able to try
different kernels.

	See You
	    Steve

--
sjh@wibble.net http://wibble.net/~sjh/
Look Up In The Sky
   Is it a bird?  No
      Is it a plane?  No
         Is it a small blue banana?
YES

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
