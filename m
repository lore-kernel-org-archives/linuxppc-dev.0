Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4263667B3D
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  6 May 2005 02:10:39 +1000 (EST)
In-Reply-To: <20050504192238.GA3461@logos.cnet>
References: <20050502204259.GB4065@logos.cnet> <4277BF8F.8040206@esteem.com>
	<20050504192238.GA3461@logos.cnet>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <22f91260e4268ca4830615ec10d0683e@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Thu, 5 May 2005 12:10:23 -0400
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: CONFIG_PIN_TLB experiments
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On May 4, 2005, at 3:22 PM, Marcelo Tosatti wrote:

> I'm trying to boot a kernel which does not create kernel pte's
> from 0xc000000 till 0xc080000.

The kernel will always (and must) create PTEs for all VM
spaces,   It's our choice to not use them.  In the case of Pinned
entries, what is supposed to happen is we load an entry that
covers a large space.  Since we never get a miss fault, we
never look at the PTE tables to load something different.

Thanks.

	-- Dan
