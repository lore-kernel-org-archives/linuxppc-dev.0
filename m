Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id AE58DDDFF9
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jan 2008 03:42:43 +1100 (EST)
Date: Tue, 8 Jan 2008 10:42:14 -0600
From: Scott Wood <scottwood@freescale.com>
To: Misbah khan <misbah_khan@engineer.com>
Subject: Re: How to write a device driver in such a fashion .????
Message-ID: <20080108164214.GB4949@loki.buserror.net>
References: <14660018.post@talk.nabble.com> <14682271.post@talk.nabble.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <14682271.post@talk.nabble.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jan 07, 2008 at 08:31:10PM -0800, Misbah khan wrote:
> 
> using mmap() in application to access the h/w is only possible if  the device
> memory is mapped in the kernel virtual memory how come we directly map to
> the physical memory to virtual from user space ??? 

No, /dev/mem takes physical addresses, not kernel virtual.

-Scott
