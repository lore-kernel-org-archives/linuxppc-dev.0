From: Joe Green <jgreen@mvista.com>
To: "Jo-Ellen F. Mathews" <joellen@absoval.com>,
        linuxppc-embedded@lists.linuxppc.org
Subject: Re: Linux Planet Module Support
Date: Thu, 16 Mar 2000 14:05:24 -0800
Content-Type: text/plain
References: <Pine.LNX.3.96.1000316161543.23230C-100000@tristar.cc.absoval.com>
In-Reply-To: <Pine.LNX.3.96.1000316161543.23230C-100000@tristar.cc.absoval.com>
MIME-Version: 1.0
Message-Id: <00031614100600.32488@minotaur.mvista.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, 16 Mar 2000, Jo-Ellen F. Mathews wrote:
> I've been working on porting our 11Mb wireless LAN device driver to
> Embedded Planet's nifty RPX-Lite (MPC823) board.  I've been using Embedded
> Planet's wonderful, new Linux Planet development kit which includes
> MontaVista's Hard Had Linux 1.0.  I'm loving this kit!
>
> I'm using the cross compiler provided on MontaVista's cd, and I've been
> very successful at compiling the default kernel and a few, simple
> programs.
>
> The most direct approach (okay, and quickest/easiest) is to keep the
> wireless lan driver as a loadable module dependent on pcmcia card
> services.  Before attempting to use Magnus Damm's pcmcia patches and
> kernel modifications to support pcmcia, I first need to recompile my
> kernel for module support.
>
> With CONFIG_MODULES enabled (regardless of what CONFIG_MODVERSIONS or
> CONFIG_KMOD are set to), I get the following errors:

If you can wait, we'll be fixing this in an upcoming kernel package.
It's mostly a matter of adding additional configuration information
(e.g., some symbols are only present if CONFIG_PCI).

--
Joe Green <jgreen@mvista.com>
MontaVista Software, Inc.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
