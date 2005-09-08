Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 862E9681EF
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  8 Sep 2005 23:57:12 +1000 (EST)
In-Reply-To: <17183.48543.616634.628331@cargo.ozlabs.ibm.com>
References: <20050907230324.GC7513@dmt.cnet> <1126139332.29803.0.camel@gaston>
	<00a1f47bb2edbbc001c2267191aa36f0@embeddededge.com>
	<20050908005821.GB8882@dmt.cnet>
	<17183.48543.616634.628331@cargo.ozlabs.ibm.com>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <d8324773c7d1a644a85a535515ac5726@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Thu, 8 Sep 2005 09:56:52 -0400
To: Paul Mackerras <paulus@samba.org>
Cc: linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] add big endian version of ld_/st_ IO access macros and
	convert main 8xx code to use it
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Sep 8, 2005, at 12:27 AM, Paul Mackerras wrote:

> Given how long it takes to access I/O devices, I don't believe an
> extra instruction or two is going to make a measurable difference.

That's kind of true.  However, the access to the CPM is nearly
instruction speed, except in the case when you actually use a
real IO register (like a GPIO on a port), then it's a little slower.


	-- Dan
