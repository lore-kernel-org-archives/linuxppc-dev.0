Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vHVr16cbrzDqJZ
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Feb 2017 14:56:01 +1100 (AEDT)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vHVr06myHz9rxw
 for <linuxppc-dev@ozlabs.org>; Tue,  7 Feb 2017 14:56:00 +1100 (AEDT)
Message-ID: <1486439737.4850.111.camel@kernel.crashing.org>
Subject: Re: [RFC PATCH 1/2] powerpc/powernv: Remove separate entry for OPAL
 real mode calls
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <pmac@au1.ibm.com>
Date: Tue, 07 Feb 2017 14:55:37 +1100
In-Reply-To: <20170207025105.GG21840@gate.crashing.org>
References: <1486433879.4850.107.camel@kernel.crashing.org>
 <20170207025105.GG21840@gate.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-02-06 at 20:51 -0600, Segher Boessenkool wrote:
> On Tue, Feb 07, 2017 at 01:17:59PM +1100, Benjamin Herrenschmidt
> wrote:
> > @@ -123,7 +149,6 @@ opal_tracepoint_entry:
> >  	ld	r9,STK_REG(R30)(r1)
> >  	ld	r10,STK_REG(R31)(r1)
> >  	LOAD_REG_ADDR(r11,opal_tracepoint_return)
> > -	mfcr	r12
> >  	std	r11,16(r1)
> >  	stw	r12,8(r1)
> >  	li	r11,0
> 
> I think you accidentally deleted this line?

Correct.

Cheers,
Ben.
