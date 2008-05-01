Return-Path: <markn@au1.ibm.com>
Received: from e23smtp01.au.ibm.com (E23SMTP01.au.ibm.com [202.81.18.162])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp01.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 46532DDDFA
	for <linuxppc-dev@ozlabs.org>; Fri,  2 May 2008 09:47:42 +1000 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.18.234])
	by e23smtp01.au.ibm.com (8.13.1/8.13.1) with ESMTP id m41NmPtv020154
	for <linuxppc-dev@ozlabs.org>; Fri, 2 May 2008 09:48:25 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m41NlYn84247700
	for <linuxppc-dev@ozlabs.org>; Fri, 2 May 2008 09:47:34 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m41NlfEe008225
	for <linuxppc-dev@ozlabs.org>; Fri, 2 May 2008 09:47:41 +1000
From: Mark Nelson <markn@au1.ibm.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 5/6] [POWERPC] Move device_to_mask() to dma-mapping.h
Date: Fri, 2 May 2008 09:47:47 +1000
References: <20080501042949.237603158@au1.ibm.com>
	<20080501043737.892888612@au1.ibm.com>
	<742b5895cdf9b898ec2b4834926a41ac@kernel.crashing.org>
In-Reply-To: <742b5895cdf9b898ec2b4834926a41ac@kernel.crashing.org>
MIME-Version: 1.0
Message-Id: <200805020947.47176.markn@au1.ibm.com>
Content-Type: text/plain;
  charset="iso-8859-1"
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 1 May 2008 07:04:30 pm Segher Boessenkool wrote:
> > Move device_to_mask() to dma-mapping.h because we need to use it from
> > outside dma_64.c in a later patch.
> 
> Why does this need to become an inline function?
> 
> 
> Segher
> 

I'm not sure exactly what you mean - it was inline before the move.

But, I honestly didn't think about it too much (although I possibly should
have)... I figured that it was static inline before my patch so I should leave
it as such.

But if everybody thinks it would be better to leave it in dma_64.c and just
expose it for use outside, I'm fine with that.

Thanks!

Mark.
