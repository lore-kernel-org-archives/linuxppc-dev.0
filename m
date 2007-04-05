Return-Path: <SRS0+dbfa744e487eb5695f7d+1320+infradead.org+dwmw2@pentafluge.srs.infradead.org>
Subject: Re: [Cbe-oss-dev] [ANNOUNCE] petitboot v0.0.1
From: David Woodhouse <dwmw2@infradead.org>
To: Jeremy Kerr <jk@ozlabs.org>
In-Reply-To: <200704052342.23662.jk@ozlabs.org>
References: <200704052342.23662.jk@ozlabs.org>
Content-Type: text/plain
Date: Thu, 05 Apr 2007 12:29:24 -0400
Message-Id: <1175790565.2719.27.camel@shinybook.infradead.org>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2007-04-05 at 23:42 +1000, Jeremy Kerr wrote:
> Benjamin Herrenschmidt and I are proud to announce the first release of 
> petitboot - a graphical bootloader for the PS3, based on twin and 
> kboot.

Fedora packages at http://david.woodhou.se/petitboot/

When I get home next week I'll work on a separate tool which can make a
zImage.ps3.rom given a kernel binary and an initrd -- much like the
existing 'mkzimage' script which does it for OF machines. Then we can
build the otheros.img without having to rebuild the kernel just to get a
zImage out of it.

Hopefully we'll have kexec working in 2.6.21 by then :)

-- 
dwmw2
