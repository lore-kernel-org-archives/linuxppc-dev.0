Message-ID: <19991209044138.23512.qmail@www0i.netaddress.usa.net>
Date: 8 Dec 99 22:41:37 CST
From: jeramy b smith <ultrapenguin@netscape.net>
To: jrestemeier@currantbun.com,
        "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
Subject: Re: [Open Sourced Glide on Linux PPC]
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> Questions:
> - Has anybody had any success compiling Glide/Linux/PPC/VooDoo1 ?
> - Is this isa_io_base thingy changed in newer kernels, or did I just mix
> up my configuration ? I don't really like downloading kernels/patches
> through my slow connections, so I'd like to be sure...
> 
> Thanks,
> Jens

I tried this beast today.
First:
I noticed 3dfx set x86 CFLAGS in the spec.The spec does this though for
glibc20 compat libs. I simply commented these lines and their respective
install lines in the spec.

Second:
swlib/include/make/3dfx.mak
This girl contains the default CFLAGS which are 486 specific. They are beside
the CNODEBUG.
I waxed em.

Third:
Ran into the same P6 fence message and some other weird looking messages at
the same place you did. My guess is that there is some inline ASM jammed in
there. The only ASM I know is IBM 370 so I was lost at this point. I *should*
have look at the c file and seen if there was an alternate c routine for the
inline ASM stuff. The sources I have have OS defs for HPUX and Solaris so
their might be portable c routines in the code. Basically, if your OSTYPE is
Linux they assume your using x86.


Afterword:
I hit the 3dfx sourceforge at sourceforge.net but nothing has been posted yet.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
