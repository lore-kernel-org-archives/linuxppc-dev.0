Date: Wed, 20 Oct 1999 15:05:02 -0500
From: anthony tong <atong@uiuc.edu>
To: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: SuSE Rage 128 Xserver Source and XFree 3.3.6
Message-ID: <19991020150502.A2198@mango.genunix.net>
References: <v03110700b433ca16486c@[209.183.133.114]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <v03110700b433ca16486c@[209.183.133.114]>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Kevin B. Hendricks (Wed, Oct 20, 1999 at 03:43:06PM -0400):
> I got tired of waiting for SuSE to release the source to its accelerated
> Xserver for Rage 128, so I sent them a nasty gram and what they replied is
> below:
> 
> So Anthony?, Tom?, Geert?, Anyone?
> 
> Do any of you know who has access to XFree 3.3.6 source code so that we can
> get started porting this server to PPC?

I have the source, and also Precision Insights additions to it (a bit 
cleaner layout + hw cursor).

I've also started merging into our xf68_fbdev but I won't have any free
time to continue this (at least for a week or so). The problem is that
they're using the xaa interface (which never was ported to ppc), so you
have to wrapper all their accel functions by hand.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
