Return-Path: <dan@embeddedalley.com>
Received: from penguin.embeddededge.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3AADCDDE2E
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 17 Oct 2007 13:11:40 +1000 (EST)
In-Reply-To: <4714E44F.7030909@freescale.com>
References: <20071015233839.959F4247BB@gemini.denx.de>
	<4714E44F.7030909@freescale.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <85100356-D95B-4343-98BE-66080EA9887D@embeddedalley.com>
From: Dan Malek <dan@embeddedalley.com>
Subject: Re: mpc 860 boot linux2.6.23 problem
Date: Tue, 16 Oct 2007 22:58:26 -0400
To: Scott Wood <scottwood@freescale.com>
Cc: "linuxppc-embedded@ozlabs.org" <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Oct 16, 2007, at 12:18 PM, Scott Wood wrote:

> Upgrading to the latest u-boot certainly shouldn't hurt, but I don't
> think there's any device tree support for 8xx yet,

Have you tried it?  Works for me.  In fact, most
of the development you see today was done
by Pantelis on the 8xx.

	-- Dan
