From: Joe Green <jgreen@mvista.com>
To: jonb@marel.is, linuxppc-embedded@lists.linuxppc.org
Subject: Re: 823e LCD display - Microwindows
Date: Thu, 28 Sep 2000 10:18:11 -0700
Content-Type: text/plain
References: <OFFAB81681.9CA422F8-ON00256968.00595E55@marel.is>
In-Reply-To: <OFFAB81681.9CA422F8-ON00256968.00595E55@marel.is>
MIME-Version: 1.0
Message-Id: <00092810205301.19171@minotaur.mvista.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, 28 Sep 2000, jonb@marel.is wrote:
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

The 823 LCD driver in CDK 1.2 is a standard framebuffer device, so you
need to select some of the framebuffer configuration options.  Take a
look at the config file for the Linuxplanet LSP.

--
Joe Green <jgreen@mvista.com>
MontaVista Software, Inc.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
