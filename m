Return-Path: <mporter@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DD2C367B71
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 31 Aug 2006 10:59:58 +1000 (EST)
Date: Wed, 30 Aug 2006 20:11:30 -0500
From: Matt Porter <mporter@embeddedalley.com>
To: Chun Chung Lo <cclo@astri.org>
Subject: Re: DS1302 driver for powerpc
Message-ID: <20060831011129.GA8863@gate.crashing.org>
References: <A7B1E4DD46AA7046A4398F745240F29402737D5E@ASPROEXG.astri.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <A7B1E4DD46AA7046A4398F745240F29402737D5E@ASPROEXG.astri.local>
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

On Thu, Aug 31, 2006 at 08:51:22AM +0800, Chun Chung Lo wrote:
> 
> Hi,
> 
> Thanks for your help.
> 
> But I also do not have this driver for 83xx. (as my linux is comes from
> Montavista)

The 83xx reference was a hypothetical. There is no 83xx driver for the
ds1302.
 
> Could you mind providing me a link / or a source of such driver for me
> to reference ?

My advice is to port the cris DS1302 driver to your board-specific
GPIO configuration. 

-Matt
