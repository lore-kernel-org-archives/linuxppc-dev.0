Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 26F98DDDFD
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 14 Sep 2007 00:13:13 +1000 (EST)
In-Reply-To: <200709131553.11853.laurentp@cse-semaphore.com>
References: <200707111517.52663.laurent.pinchart@technotrade.biz>
	<200709131553.11853.laurentp@cse-semaphore.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <E59EA21D-A203-41F1-BADD-D728D76F270E@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 1/2] [POWERPC] Add SCC clock support to cpm2_clk_setup()
Date: Thu, 13 Sep 2007 09:16:02 -0500
To: Laurent Pinchart <laurentp@cse-semaphore.com>
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


On Sep 13, 2007, at 8:53 AM, Laurent Pinchart wrote:

> On Wednesday 11 July 2007 15:17, Laurent Pinchart wrote:
>> cpm2_clk_setup() supports setting FCC clocks only, even though the
>> cpm_clk_target enumeration lists SCC clocks. This patch adds SCC  
>> clock
>> support.
>
> Any chance this patch (and its 2/2 brother) could be committed ?

Have you looked at Scott Wood's cleanup patches.  They seem to do  
some of this.

- k
