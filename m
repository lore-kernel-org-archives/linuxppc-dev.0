Message-ID: <3A9161AA.FAD05E67@mvista.com>
Date: Mon, 19 Feb 2001 13:10:50 -0500
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Rolf Liu <rolfl@sc.mcel.mot.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: why there is NOT support for FADS board ?
References: <033b01c09a52$e88f11e0$bf0102c8@sc.mcel.mot.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Rolf Liu wrote:
>
> Hi, all,
> I can see supports for MBX, RPXLITE, RPXCLASSIC, etc.
> but why not FADS support in linux ppc ?

Because the FADS board is a pain in the ass to support.  I had some
of it in the kernel years ago, then didn't have access to any hardware
so I couldn't support it.

I have recently done the port again and you can find the initial
work on MontaVista server, in Area51.  It is in the pipeline to get
back into baseline kernel.  The MontaVista kernel is for the 860,
and I have recevied patches for the 823, so both will be there.

Maybe you would like to support it :-)?


	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
