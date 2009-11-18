Return-Path: <ptyser@xes-inc.com>
Received: from xes-mad.com (xes-mad.com [216.165.139.218])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7C2DFB6F14
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Nov 2009 08:51:26 +1100 (EST)
Subject: Re: [PATCH 0/3] powerpc: Add support for FIT uImages
From: Peter Tyser <ptyser@xes-inc.com>
To: linuxppc-dev@ozlabs.org
In-Reply-To: <1258577834-26006-1-git-send-email-ptyser@xes-inc.com>
References: <1258577834-26006-1-git-send-email-ptyser@xes-inc.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 18 Nov 2009 15:51:21 -0600
Message-ID: <1258581081.8365.5996.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linux-kbuild@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2009-11-18 at 14:57 -0600, Peter Tyser wrote:
> These patches add support for creating the "new" FIT uImage type
> that U-Boot can use.  Additional info about FIT images can be
> found in the doc/uImage.FIT/ directory of the U-Boot source.
> Here's a link to a howto which gives an overview of the format:
> http://git.denx.de/cgi-bin/gitweb.cgi?p=u-boot.git;a=blob;f=doc/uImage.FIT/howto.txt;h=8065e9e1d8d4d65a9b5fe0fce08d3709183d0ee4;hb=HEAD
> 
> I've only added support for PowerPC, but the arm, avr32, blackfin,
> and sh arches could use the same framework in theory.  The change
> is especially useful on PowerPC since it creates 1 FIT uImage that
> combines the functionality of an "old" uImage format, a device
> tree blob, and possibly a ramdisk.
> 
> Peter Tyser (3):
>   powerpc: Use scripts/mkuboot.sh instead of 'mkimage'
>   powerpc: Add support for creating FIT uImages
>   powerpc: Add support for ram filesystems in FIT uImages
> 
>  arch/powerpc/Makefile        |    4 +-
>  arch/powerpc/boot/.gitignore |    1 +
>  arch/powerpc/boot/Makefile   |    8 ++-
>  arch/powerpc/boot/wrapper    |   39 ++++++++++--
>  scripts/mkits.sh             |  144 ++++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 189 insertions(+), 7 deletions(-)
>  create mode 100755 scripts/mkits.sh

Just realized I missed /Documentation/powerpc/bootwrapper.txt in this
series.  I'll wait for feedback and roll the documentation update and
any other requested changes into v2.

Sorry for the noise,
Peter
