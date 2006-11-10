Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B396D67DD9
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Nov 2006 00:14:58 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e5.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id kAADEsdq005730
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Nov 2006 08:14:54 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	kAADEsdK307664
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Nov 2006 08:14:54 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	kAADEsjF002884
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Nov 2006 08:14:54 -0500
Subject: Re: ipr SATA support is causing problems
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17748.27504.715056.565983@cargo.ozlabs.ibm.com>
References: <17748.25705.543922.486456@cargo.ozlabs.ibm.com>
	<1163159326.19697.23.camel@crusty.rchland.ibm.com>
	<17748.27504.715056.565983@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Fri, 10 Nov 2006 07:14:59 -0600
Message-Id: <1163164499.4168.3.camel@zod.rchland.ibm.com>
Mime-Version: 1.0
Cc: akpm@osdl.org, James Bottomley <jejb@mulgrave.il.steeleye.com>,
	linuxppc-dev@ozlabs.org, torvalds@osdl.org, Jeff Garzik <jgarzik@pobox.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2006-11-10 at 23:07 +1100, Paul Mackerras wrote:
> Josh Boyer writes:
> 
> > John Rose reported this a few days ago.  Brian responded with this:
> > 
> > http://marc.theaimsgroup.com/?l=linux-ide&m=116169938407596&w=2
> 
> Didn't John say he still saw the crash with that change?

He did on my suggestion, which technically wasn't correct.  I haven't
seen anything from him after Brian replied with a real patch.

I know I helped debug a crash that looked very much like that on a P5
box with a 2.6.19-rcX kernel and Brian's patch fixed it.

josh
