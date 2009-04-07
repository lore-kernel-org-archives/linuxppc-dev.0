Return-Path: <subrata@linux.vnet.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 1AD8CDDFB2
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Apr 2009 18:48:55 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e6.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n378oUMm004371
	for <linuxppc-dev@ozlabs.org>; Tue, 7 Apr 2009 04:50:30 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n378mplW193624
	for <linuxppc-dev@ozlabs.org>; Tue, 7 Apr 2009 04:48:51 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n378moHj021204
	for <linuxppc-dev@ozlabs.org>; Tue, 7 Apr 2009 04:48:51 -0400
Subject: Re: [LTP] [PATCH] powerpc: wire up preadv and pwritev
From: Subrata Modak <subrata@linux.vnet.ibm.com>
To: Gerd Hoffmann <kraxel@redhat.com>, Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <49DB0628.70502@redhat.com>
References: <20090407131950.9ab4430b.sfr@canb.auug.org.au>
	<bb33bcf20904062351p63645851h9b33d47f57c57e7f@mail.gmail.com>
	<49DB0628.70502@redhat.com>
Content-Type: text/plain
Date: Tue, 07 Apr 2009 14:18:47 +0530
Message-Id: <1239094128.5300.13.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Cc: ltp-list <ltp-list@lists.sf.net>, maknayak@in.ibm.com,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Subrata Modak <tosubrata@gmail.com>
Reply-To: subrata@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Thanks Gerd/Stephen,

On Tue, 2009-04-07 at 09:52 +0200, Gerd Hoffmann wrote:
> Hi,
> 
> > How about contributing the above test to LTP(http://ltp.sourceforge.net/)
> > under GPL ? If you agree, i would soon send you a Patch integrating the same
> > to LTP.
> 
> Fine with me.  You probably want to remove the hard-coded syscall 
> numbers and pickup them from unistd.h instead though.

Sure. We will do some necessary changes, and you will shortly hear from
us the Patch to integrate, and, retaining your Copyright on the test
program.

Regards--
Subrata

> 
> cheers,
>    Gerd
> 
> 
> ------------------------------------------------------------------------------
> This SF.net email is sponsored by:
> High Quality Requirements in a Collaborative Environment.
> Download a free trial of Rational Requirements Composer Now!
> http://p.sf.net/sfu/www-ibm-com
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
