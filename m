Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 77271681CC
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  8 Sep 2005 10:42:57 +1000 (EST)
In-Reply-To: <1126139332.29803.0.camel@gaston>
References: <20050907230324.GC7513@dmt.cnet> <1126139332.29803.0.camel@gaston>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <00a1f47bb2edbbc001c2267191aa36f0@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Wed, 7 Sep 2005 20:42:42 -0400
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>,
	linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
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


On Sep 7, 2005, at 8:28 PM, Benjamin Herrenschmidt wrote:

> I'm not fan of the approach. You should use in_/out_ macros for IOs. If
> you don't need eieio on 8xx , then just #ifdef it out of the
> implementation of these.

Yeah, #ifdef :-)  That patch wouldn't go anywhere (well,
to /dev/null perhaps).

We can just use the in_/out_ macros that are there.  The eieio
doesn't hurt anything on the 8xx.

Thanks.

	-- Dan
