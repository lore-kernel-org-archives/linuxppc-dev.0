Message-ID: <38E93D4B.6BDE311@wibble.net>
Date: Tue, 04 Apr 2000 10:54:35 +1000
From: Steven Hanley <sjh@wibble.net>
MIME-Version: 1.0
To: Linux PPC Dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: problems with the frame buffer (ATV 64) on a power mac 7220 in   newer kernels
References: <200004030925.LAA00262@piglet.grunz.lu>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michel Lanners wrote:

> > I tried a kernel command line of video=controlfb:vmode:5
>                                          ^^^^^^^^^
> I didn't know the 7220 had a control display adapter? Anyway, this
> option will do nothing for your ATI display. You need to look at atyfb
> for relevant options.

I have no idea what the hardware actually has or doesnt, however as
mentioned in the email I did try a plain video=vmode:6 also which if I
read line 3279 of atyfb.c correctly (2.2.15pre14)

3278-#if defined(CONFIG_PPC)
3279:   else if (!strncmp(this_opt, "vmode:", 6)) {
3280-       unsigned int vmode = simple_strtoul(this_opt+6, NULL, 0);
3281-       if (vmode > 0 && vmode <= VMODE_MAX)
3282-           default_vmode = vmode;

should set the vmode correctly to whatever I pass, instead it still just
goes with 6 seemingly due to code paulus added since 2.2.10.

I would love for someone to clear this up for me. how do I make a recent
kernel show anything at all on the screen, it still wont yet 2.2.10
seems to be fine no matter how much I muck around with different weird
config options.

Thanks

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
