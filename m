Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C97BADDEB6
	for <linuxppc-dev@ozlabs.org>; Sun, 22 Jul 2007 11:52:05 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l6M1q2w4012642
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Jul 2007 21:52:02 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l6M1q2gM531566
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Jul 2007 21:52:02 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l6M1q1SJ012031
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Jul 2007 21:52:01 -0400
Date: Sat, 21 Jul 2007 21:04:13 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: Someone broke my allmodconfig build
Message-ID: <20070722020412.GQ3925@crusty.rchland.ibm.com>
References: <20070722001212.5007001d.sfr@canb.auug.org.au>
	<18082.42674.651685.720737@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <18082.42674.651685.720737@cargo.ozlabs.ibm.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Jul 22, 2007 at 10:37:06AM +1000, Paul Mackerras wrote:
> Stephen Rothwell writes:
> 
> >   WRAP    arch/powerpc/boot/zImage.ps3
> > /home/sfr/kernels/linus/arch/powerpc/boot/wrapper: line 113: dtc: command not found
> > make[2]: *** [arch/powerpc/boot/zImage.ps3] Error 1
> 
> Hmmm, we should be shipping .dtb files with the tree, so people don't
> have to have dtc installed.

Really?  I don't think we're quite ready for that.  Particularly for the
embedded boards.  Those DTS files still get lots of churn, and having to
update both the .dts and .dtb at the same time seems a bit fragile.

josh
