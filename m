Date: Tue, 25 Feb 2003 21:52:59 -0700
From: Matt Porter <porter@cox.net>
To: Eugene Surovegin <ebs@ebshome.net>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Kernel Preemption patch
Message-ID: <20030225215259.D11988@home.com>
References: <5.1.0.14.2.20030224135756.0465b778@mail.ebshome.net> <995FF289C9D69747A09E42992644595405B23686@penguin.adic.com> <5.1.0.14.2.20030224135756.0465b778@mail.ebshome.net> <20030225211843.B11988@home.com> <5.1.0.14.2.20030225202432.0377ac88@mail.ebshome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5.1.0.14.2.20030225202432.0377ac88@mail.ebshome.net>; from ebs@ebshome.net on Tue, Feb 25, 2003 at 08:25:33PM -0800
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Feb 25, 2003 at 08:25:33PM -0800, Eugene Surovegin wrote:
>
> At 08:18 PM 2/25/2003, Matt Porter wrote:
>
> >I placed Eugene's patch at ftp://source.mvista.com/pub/linuxppc/
>
> This patch is against 2.4.19 PPC devel kernel (bk cset 1.1091.1.23, 3rd of
> August 2002).
> It contains the following:
>
> 1) preempt kernel (preempt-kernel-rml-2.4.19-rc5-3.patch + MV fixes)
> 2) lock-break (lock-break-rml-2.4.18-1.patch)
> 3) rtsched (rtsched-2.4.16-1.0.patch + my fixes)
> 4) LTT (linux trace toolkit) (0.9.5a release)

Oops, yeah, well I just added this text to a README.pk-rtsched-ltt at
the site.  FWIW, I also added a README.biphys_remap to that patch to
and noted the originator of each.  If anybody sends additional useful
patches I'll try to do the same so they make sense 6 months from now. :)

Regards,
--
Matt Porter
porter@cox.net
This is Linux Country. On a quiet night, you can hear Windows reboot.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
