Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C89EA67A65
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 20 Jan 2005 04:26:03 +1100 (EST)
In-Reply-To: <BCEFJBPJCGFCNMMMIDBHOECCCKAA.Joakim.Tjernlund@lumentis.se>
References: <BCEFJBPJCGFCNMMMIDBHOECCCKAA.Joakim.Tjernlund@lumentis.se>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <28C8C10C-6A3F-11D9-9943-003065F9B7DC@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Wed, 19 Jan 2005 12:25:48 -0500
To: Joakim.Tjernlund@lumentis.se
Cc: Tom Rini <trini@kernel.crashing.org>,
	"Linuxppc-Embedded@Ozlabs. Org" <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] Handle I-TLB Error and Miss separately on 8xx
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Jan 18, 2005, at 5:02 PM, Joakim Tjernlund wrote:

> Then all that is missing is my dcbX patch and support for 16K pages :)

We'll get to that.  I'd prefer to support 4K and 8M pages, though.  I 
had
started on doing that, some code remnants are still there, but I never
got it to work without adding too much code to the I-tlbmiss hander.
I want an tlbmiss handler like the example in the manual, about 10
lines of straight code.  I don't like to be mucking around with PTE 
entries
a higher level function could/should have set for us in a less critical 
path.

	-- Dan
