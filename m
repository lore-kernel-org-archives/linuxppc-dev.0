Return-Path: <will_schmidt@vnet.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1B2A3DDDF3
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Feb 2007 03:38:48 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e5.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l17GciAd016096
	for <linuxppc-dev@ozlabs.org>; Wed, 7 Feb 2007 11:38:44 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.2) with ESMTP id
	l17GcaJa060554
	for <linuxppc-dev@ozlabs.org>; Wed, 7 Feb 2007 11:38:36 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l17GcaVb003716
	for <linuxppc-dev@ozlabs.org>; Wed, 7 Feb 2007 11:38:36 -0500
Subject: Re: patches in powerpc.git
From: Will Schmidt <will_schmidt@vnet.ibm.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20070207155515.be5d0d5e.sfr@canb.auug.org.au>
References: <17865.20353.116215.380614@cargo.ozlabs.ibm.com>
	<20070207155515.be5d0d5e.sfr@canb.auug.org.au>
Content-Type: text/plain
Date: Wed, 07 Feb 2007 10:38:30 -0600
Message-Id: <1170866310.6619.55.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
Reply-To: will_schmidt@vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-07-02 at 15:55 +1100, Stephen Rothwell wrote:
> On Wed, 7 Feb 2007 15:03:13 +1100 Paul Mackerras <paulus@samba.org> wrote:
> >
> > If anyone has patches not listed here that they want in 2.6.21, please
> > let me or the relevant sub-arch maintainer know.
> 
> How about "Fix ppc64's writing to struct file_operations" sent to you
> yesterday by Andrew Morton.
> 

Is this the lparcfg fops .write changes that came across LKML
mid-January?    I didnt notice any references to it here.. 
-Will

> --
> Cheers,
> Stephen Rothwell                    sfr@canb.auug.org.au
> http://www.canb.auug.org.au/~sfr/
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
