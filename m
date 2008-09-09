Return-Path: <jwboyer@gmail.com>
Received: from mail-gx0-f21.google.com (mail-gx0-f21.google.com
	[209.85.217.21]) by ozlabs.org (Postfix) with ESMTP id D2D0EDE09D
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 10 Sep 2008 03:34:42 +1000 (EST)
Received: by gxk14 with SMTP id 14so10977366gxk.9
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 09 Sep 2008 10:34:42 -0700 (PDT)
Date: Tue, 9 Sep 2008 13:33:54 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Georg Schardt <schardt@team-ctech.de>
Subject: Re: Device Tree
Message-ID: <20080909173336.GA16093@yoda.jdub.homelinux.org>
References: <48C69990.9040604@team-ctech.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <48C69990.9040604@team-ctech.de>
Sender: Josh Boyer <jwboyer@gmail.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, Sep 09, 2008 at 05:43:12PM +0200, Georg Schardt wrote:
> Hi,
>
> im searching for informations about the flatten device trees. the only  
> thing i know is, that the device tree is a kind of data-structure which  
> the bios or bootloader gives to the operation system.
>
> until now, i boot linux with uboot without a device tree, but newer  
> kernel wants a devicetree, i think ??
> i use a virtex4 board with an integrated powerpc
>
> how can i create the device tree file ?
> how must the linux kernel be configured ?
> is there a good internet page with informations ?

In the kernel, look at Documentation/powerpc/booting-without-of.txt

You could also read the "A Symphony of Flavours: Using the device tree to
describe embedded hardware" paper on page 27 of:

http://www.linuxsymposium.org/2008/ols-2008-Proceedings-V2.pdf

josh
