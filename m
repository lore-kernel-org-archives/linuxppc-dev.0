Return-Path: <segher@gate.crashing.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vHTPx2BRmzDqBN
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Feb 2017 13:51:49 +1100 (AEDT)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vHTPw3qD6z9s7m
 for <linuxppc-dev@ozlabs.org>; Tue,  7 Feb 2017 13:51:48 +1100 (AEDT)
Date: Mon, 6 Feb 2017 20:51:06 -0600
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <pmac@au1.ibm.com>
Subject: Re: [RFC PATCH 1/2] powerpc/powernv: Remove separate entry for OPAL
 real mode calls
Message-ID: <20170207025105.GG21840@gate.crashing.org>
References: <1486433879.4850.107.camel@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1486433879.4850.107.camel@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Feb 07, 2017 at 01:17:59PM +1100, Benjamin Herrenschmidt wrote:
> @@ -123,7 +149,6 @@ opal_tracepoint_entry:
>  	ld	r9,STK_REG(R30)(r1)
>  	ld	r10,STK_REG(R31)(r1)
>  	LOAD_REG_ADDR(r11,opal_tracepoint_return)
> -	mfcr	r12
>  	std	r11,16(r1)
>  	stw	r12,8(r1)
>  	li	r11,0

I think you accidentally deleted this line?


Segher
