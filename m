Message-ID: <3BF040CD.560358DB@iiic.ethz.ch>
Date: Mon, 12 Nov 2001 22:36:13 +0100
From: Michel =?iso-8859-1?Q?D=E4nzer?= <michdaen@iiic.ethz.ch>
MIME-Version: 1.0
To: Adrian Cox <adrian@humboldt.co.uk>
Cc: linuxppc-dev@lists.linuxppc.org,
	linux-fbdev-devel@lists.sourceforge.net
Subject: Re: Scaling registers on r128
References: <3BEF952D.9000306@humboldt.co.uk>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Adrian Cox wrote:
>
> This patch to aty128fb is experimental, and intended for the brave.
>
> The attached patch turns on the panel scaling registers of the R128.
> I've run this on my iBook2, and I've been able to display 640x480 and
> 800x600 modes on the panel successfully.
>
> The panel sizes are currently hardwired on the iBook. This code will
> benefit greatly from a reliable means to find the panel size.
>
> This has revealed problems in the X server: if the XF86Config-4
> specifies 800x600 and the current console is in 1024x768, the display
> is broken.

Does switching resolutions in X fix it again?

> This looks like a generic problem in fbdevhw based Xservers, as
> I saw something similar on 69030.

Yes, I suspect some fbdevHW functions return information about the
current console mode instead of the one the X server wants to set up.
I'm not sure how to fix, you seem to be working a lot with that code
recently so I expect you to find a way. :)


--
Earthling Michel Dänzer (MrCooper)/ Debian GNU/Linux (powerpc) developer
XFree86 and DRI project member   /  CS student, Free Software enthusiast

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
