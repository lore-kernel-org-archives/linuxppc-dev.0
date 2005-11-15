Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 89F0C68767
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 15 Nov 2005 11:27:57 +1100 (EST)
In-Reply-To: <475D0B8F-FF5A-44DC-9D03-7156AFE2AAB0@kernel.crashing.org>
References: <20051114152024.GA29314@logos.cnet>
	<5F8A6977-E33A-4E84-B029-D1B49716DC82@kernel.crashing.org>
	<20051114155313.GA29411@logos.cnet>
	<608ff4f57a546901e9193ebbbe368053@embeddededge.com>
	<475D0B8F-FF5A-44DC-9D03-7156AFE2AAB0@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <f1398690ca38921aacd6daf98935b5f2@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Mon, 14 Nov 2005 19:27:49 -0500
To: Kumar Gala <galak@kernel.crashing.org>
Cc: linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: [Edson.Seabra@cyclades.com: Re: BDI and 85xx]
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Nov 14, 2005, at 5:50 PM, Kumar Gala wrote:

> I'm not 100% sure this is even possible on some of the book-e variants.

I suspect we could if we didn't just keep whacking
the MSR with some constant value :-) What
happens if we just leave DE set all of the time?
I know as part of ptrace, etc. it can get manipulated,
but if we are debugging through COP we shouldn't
get to these software functions.

	-- Dan
