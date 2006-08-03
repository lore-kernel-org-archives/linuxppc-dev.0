Return-Path: <msm@freescale.com>
Subject: Re: [RFC] New target 'cuImage' - compatibility uImage
From: Matthew McClintock <msm@freescale.com>
To: Wolfgang Denk <wd@denx.de>
In-Reply-To: <20060803202325.4566C352660@atlas.denx.de>
References: <20060803202325.4566C352660@atlas.denx.de>
Content-Type: text/plain
Date: Thu, 03 Aug 2006 15:31:52 -0500
Message-Id: <1154637113.5094.52.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2006-08-03 at 22:23 +0200, Wolfgang Denk wrote:
> > I'm referring to the zImage target as what the current method does.
> My
> 
> This is highly confusing. zImage is a special make target, which  has
> NOTHING  to  do with U-Boot. Please don't use this name in the U-Boot
> context unleass you really mean it.
> 

AFAIK, there are no other targets that include the bootwrapper code
other than zImage. It was a very nice starting point for me to explain
the differences. If you don't want to ask questions and have me try to
further clarify things I cannot help.

The 'cuImage' target as I described is *basically* the following:

$ make zImage
$ mkimage -A ppc -O linux -T kernel -C gzip -a 400000 -e 400010 -n
'Linux-2.6.18' -d arch/powerpc/boot/zImage arch/powerpc/boot/cuImage

> > The zImage can have a compressed kernel section or an uncompressed
> 
> I stop parsing here. zImage has *nothing* to do with this topic. 

Your loss.

-Matthew
