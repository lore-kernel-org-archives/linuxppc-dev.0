Message-ID: <39D3891D.2C82F64E@mvista.com>
Date: Thu, 28 Sep 2000 11:08:29 -0700
From: Matthew Locke <mlocke@mvista.com>
MIME-Version: 1.0
To: jonb@marel.is
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: 823e LCD display - Microwindows
References: <OFFAB81681.9CA422F8-ON00256968.00595E55@marel.is>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


jonb@marel.is wrote:
>
> Hi
>
> I have now successfully gotten Linux running on a custom 823e board,
> using Monta Vista CDK 1.2, Linux version 2.2.14.  I am using an NFS
> root file system and I have created a custom lsp for the board.
>
> Our board uses the 823 LCD controller for a 640x480 TFT display.
>
> I would like to activate the 823 LCD driver and try out the Microwindows
> demo from Monta Vista, but I do not know what needs to be done.
>
> When I configure the kernel with CONFIG_RPXLCD, I get a lot of
> undefined symbols when linking the kernel, such as fb_display,
> fb_default_cmap.
>
> Can anyone point me in the right direction ?

Enable framebuffer support in the kernel configuration.

Matthew Locke
Montavista Software

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
