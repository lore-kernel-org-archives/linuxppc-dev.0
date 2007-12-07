Return-Path: <dwg@au1.ibm.com>
Received: from e23smtp02.au.ibm.com (E23SMTP02.au.ibm.com [202.81.18.163])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp02.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 5FB1DDDE1F
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Dec 2007 15:18:33 +1100 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.18.234])
	by e23smtp02.au.ibm.com (8.13.1/8.13.1) with ESMTP id lB74Hjwi032456
	for <linuxppc-dev@ozlabs.org>; Fri, 7 Dec 2007 15:17:45 +1100
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	lB74HXBA3584050
	for <linuxppc-dev@ozlabs.org>; Fri, 7 Dec 2007 15:17:33 +1100
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lB74HEbo003687
	for <linuxppc-dev@ozlabs.org>; Fri, 7 Dec 2007 15:17:15 +1100
Date: Fri, 7 Dec 2007 15:16:59 +1100
From: David Gibson <dwg@au1.ibm.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: dtc: Reinstate full old-style reference-to-path for v0 dts files
Message-ID: <20071207041659.GE26412@localhost.localdomain>
References: <20071207033826.GD26412@localhost.localdomain>
	<20071206213928.1f6a2e1f@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071206213928.1f6a2e1f@zod.rchland.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Dec 06, 2007 at 09:39:28PM -0600, Josh Boyer wrote:
> On Fri, 7 Dec 2007 14:38:26 +1100
> David Gibson <david@gibson.dropbear.id.au> wrote:
> 
> > Commit 7c44c2f9cb1cc2df7aacd13decfc4e64b73d1730 broke backwards
> > compatibility more badly than I realised.  Contrary to what I thought
> > there are in-kernel, in-use dts files which relied on
> > references-to-path with paths including a comma, which no longer
> > compile after that commit.
> 
> There won't be shortly.  I'm reworking them anyway.

I know, but I'd prefer that there was a broken range of dtc versions
than a broken range of kernel versions.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
