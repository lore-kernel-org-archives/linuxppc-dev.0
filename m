Return-Path: <will_schmidt@vnet.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id EBCBDDDE27
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Jun 2007 00:48:45 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e5.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l56Emgpl025640
	for <linuxppc-dev@ozlabs.org>; Wed, 6 Jun 2007 10:48:42 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l56EmeIj525098
	for <linuxppc-dev@ozlabs.org>; Wed, 6 Jun 2007 10:48:40 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l56Emeab014627
	for <linuxppc-dev@ozlabs.org>; Wed, 6 Jun 2007 10:48:40 -0400
Subject: Re: [patch 02/18] PS3: Rename IPI symbols
From: Will Schmidt <will_schmidt@vnet.ibm.com>
To: Geoff Levand <geoffrey.levand@am.sony.com>
In-Reply-To: <20070606131157.133ce9bb.sfr@canb.auug.org.au>
References: <20070606024407.786638029@am.sony.com>
	<4666230D.4020902@am.sony.com>
	<20070606131157.133ce9bb.sfr@canb.auug.org.au>
Content-Type: text/plain
Date: Wed, 06 Jun 2007 09:48:32 -0500
Message-Id: <1181141312.18837.6.camel@farscape.rchland.ibm.com>
Mime-Version: 1.0
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Paul Mackerras <paulus@samba.org>,
	linuxppc-dev@ozlabs.org
Reply-To: will_schmidt@vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-06-06 at 13:11 +1000, Stephen Rothwell wrote:
> On Tue, 05 Jun 2007 19:59:25 -0700 Geoff Levand <geoffrey.levand@am.sony.com> wrote:
> >
> > Rename the PS3 static symbol virqs to ps3_ipi_virqs to aid in
> > debugging.
> > 
> > Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
> >
> >  	for (i = 0; i < MSG_COUNT; i++) {
> > -		free_irq(virqs[i], (void*)(long)i);
> > +		/* Can't call free_irq from interrupt context. */
> 
> This change is probably worth a mention in the change log - it looks like
> a bug fix.


Does the free_irq call (being removed here) need to be added back in
somewhere else? 

-Will

> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
