Return-Path: <Phil.Nitschke@avalon.com.au>
Received: from camden.avalon.com.au (unknown [150.101.131.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 27892679E6
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 17 Feb 2006 09:20:01 +1100 (EST)
From: Phil Nitschke <Phil.Nitschke@avalon.com.au>
To: "Buhler, Greg" <greg.buhler@viasat.com>
Subject: Re: scatter/gather DMA and cache coherency
References: <68997D3094017740BB875EB2A425A6EA02E46197@VCAEXCH01.hq.corp.viasat.com>
Date: Fri, 17 Feb 2006 08:49:50 +1030
In-Reply-To: <68997D3094017740BB875EB2A425A6EA02E46197@VCAEXCH01.hq.corp.viasat.com>
	(Greg Buhler's message of "Thu, 16 Feb 2006 10:23:20 -0800")
Message-ID: <kw3bijdjzt.fsf@lamorak.int.avalon.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-embedded@ozlabs.org
Reply-To: Phil.Nitschke@avalon.com.au
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

>>>>> "GB" == Buhler, Greg <greg.buhler@viasat.com> writes:

  GB> Phil, If the third party DMA driver is not proprietary send it
  GB> over and I'd be happy to take a look at it for you. 

I don't think I can, due to this in the code:

========================================================================
/*
Copyright Notice:
  This computer software is proprietary to VMETRO. The use of this software
  is governed by a licensing agreement. VMETRO retains all rights under
  the copyright laws of the United States of America and other countries.
  This software may not be furnished or disclosed to any third party and
  may not be copied or reproduced by any means, electronic, mechanical, or
  otherwise, in whole or in part, without specific authorization in writing
  from VMETRO.
 
    Copyright (c) 1996-2005 by VMETRO, ASA.  All Rights Reserved.
*/

[snip]

/* Set the right GPL license to avoid warrnings then loading the driver */
MODULE_LICENSE("GPL");
========================================================================

Can you have a GPL driver where the source is copyright?

Thanks for the offer, Greg.

-- 
Phil
