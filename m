Message-ID: <39BD66B9.9A1A362F@mvista.com>
Date: Mon, 11 Sep 2000 16:11:53 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
Reply-To: mgreer@mvista.com
MIME-Version: 1.0
To: Alex Shnitman <alexsh@hectic.net>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Sandpoint & random crashes?
References: <2F67A63DFFB1D31185D90090278CBB2D014ECF08@apmail6.chn.agilent.com> <39BD4215.6FD9B56F@mvista.com> <20000912001214.B17705@hectic.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Alex Shnitman wrote:

> Hi, Mark!
> Today I think I noticed a very interesting consistency that might be
> helpful. I haven't had the time to test it completely; I'll do it
> tomorrow and post again. The thing is, there's a little green led on
> the board saying "backup power" or something like that. If you turn
> off the computer and the power supply, and leave it off for half a
> minute or so, the led turns off. If you turn the computer on
> afterwards and load the kernel, it loads init and you can work (until
> it crashes). If you just reset the computer and load the kernel (after
> uploading it via dink of course), init won't load.
>

This almost sounds like a hardware problem.  How old is your processor module?
Remember this is a test platform for MOT SPS where they test out new processors,
etc.  They may have given you an early rev board or processor or host bridge or...
If you have an old one, you may want to ask for a newer one.

I perused through /proc cat-ing files as well.  Haven't had any problems.  I'll
keep an eye out.   Please let me/us know what you discover in the meantime.

Thanks,

Mark


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
