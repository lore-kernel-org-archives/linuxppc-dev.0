Return-Path: <jdl@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E7864DE0CD
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jan 2008 02:12:12 +1100 (EST)
Message-ID: <4798A9C2.9070801@freescale.com>
Date: Thu, 24 Jan 2008 09:07:46 -0600
From: Jon Loeliger <jdl@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 3/4 v4] POWERPC: Add initial iomega StorCenter board port.
References: <E1JHkYk-00010g-M2@jdl.com>	<20080124115018.69551acf.sfr@canb.auug.org.au>
	<3C9ED1A8-7F51-41B8-898C-45BDA3EF4548@kernel.crashing.org>
In-Reply-To: <3C9ED1A8-7F51-41B8-898C-45BDA3EF4548@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Jon Loeliger <jdl@jdl.com>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> On Jan 23, 2008, at 6:50 PM, Stephen Rothwell wrote:
> 
>> You need an of_node_put(dnp) before you return.
> 
> Fixed up by your friendly maintainer.

Kumar,

I meant, "I won't be sending you a patch."

Thank you!

jdl
