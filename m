Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 66CF2679F0
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 17 Feb 2006 09:52:29 +1100 (EST)
Date: Thu, 16 Feb 2006 14:52:26 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: Phil Nitschke <Phil.Nitschke@avalon.com.au>
Subject: Re: scatter/gather DMA and cache coherency
Message-ID: <20060216225226.GA3694@gate.ebshome.net>
References: <68997D3094017740BB875EB2A425A6EA02E46197@VCAEXCH01.hq.corp.viasat.com>
	<kw3bijdjzt.fsf@lamorak.int.avalon.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <kw3bijdjzt.fsf@lamorak.int.avalon.com.au>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, Feb 17, 2006 at 08:49:50AM +1030, Phil Nitschke wrote:
> >>>>> "GB" == Buhler, Greg <greg.buhler@viasat.com> writes:
> 
>   GB> Phil, If the third party DMA driver is not proprietary send it
>   GB> over and I'd be happy to take a look at it for you. 
> 
> I don't think I can, due to this in the code:
> 
> ========================================================================
> /*
> Copyright Notice:
>   This computer software is proprietary to VMETRO. The use of this software
>   is governed by a licensing agreement. VMETRO retains all rights under
>   the copyright laws of the United States of America and other countries.
>   This software may not be furnished or disclosed to any third party and
>   may not be copied or reproduced by any means, electronic, mechanical, or
>   otherwise, in whole or in part, without specific authorization in writing
>   from VMETRO.
>  
>     Copyright (c) 1996-2005 by VMETRO, ASA.  All Rights Reserved.
> */
> 
> [snip]
> 
> /* Set the right GPL license to avoid warrnings then loading the driver */
> MODULE_LICENSE("GPL");
> ========================================================================
> 

I'm not a lawyer, but what they are doing is of questionable legality 
at least, they circumvent Linux protection but claiming that module is 
GPL, but that copyright notice isn't GPL compatible.

If you are going to sell systems with this module, you may have 
trouble with your customers, because you'll clearly be violating GPL.

My experience with such vendors - their code isn't worth the trouble 
(I have yet to see good Linux driver written by hw vendor) and I'd 
rather avoid them completely.

-- 
Eugene
