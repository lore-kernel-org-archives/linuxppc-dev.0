Return-Path: <olaf@ibook.aepfle.de>
Received: from natlemon.rzone.de (natlemon.rzone.de [81.169.145.170])
	by ozlabs.org (Postfix) with ESMTP id 9EC1B67B62
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Sep 2006 02:01:13 +1000 (EST)
Date: Mon, 11 Sep 2006 18:01:08 +0200
From: Olaf Hering <olaf@aepfle.de>
To: ppc64@storix.com
Subject: Re: Kernel panic: kernel access of bad area pc
Message-ID: <20060911160108.GA25669@aepfle.de>
References: <200609081532.59764.ppc64@storix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <200609081532.59764.ppc64@storix.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Sep 08, ppc64@storix.com wrote:

> I have a process to create tape boot images by combining the kernel and initrd 
> into a zImage. The process works for 2.4 (RHEL 3.3) & 2.6 kernels (SLES9 & 
> RHEL4). However on SLES8 ppc64 the kernel panics with "error kernel access of 
> bad area pc". 

What do you use to create the zImage header? 
Also, does the SP3 kernel work any better? The reiserfs mem corruption
has likely has likely the same cause as the ramdisk corruption.
