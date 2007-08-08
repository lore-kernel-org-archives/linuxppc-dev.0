Return-Path: <scottwood@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C3E87DDE37
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Aug 2007 02:30:04 +1000 (EST)
Message-ID: <46B9EF7D.8060908@freescale.com>
Date: Wed, 08 Aug 2007 11:29:49 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Alexandros Kostopoulos <akostop@inaccessnetworks.com>
Subject: MPC8260 PCI9 erratum
References: <op.twhnwi18nhx3hy@phoenix>
	<20070803201036.GA18229@ld0162-tx32.am.freescale.net>
	<F081E320-CFF9-497C-87D5-50E2E5C15A24@kernel.crashing.org>
	<op.twol4cixnhx3hy@phoenix> <46B88DAC.70005@freescale.com>
	<op.twqn4vtsnhx3hy@phoenix>
In-Reply-To: <op.twqn4vtsnhx3hy@phoenix>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Alexandros Kostopoulos wrote:
> On Tue, 07 Aug 2007 18:20:12 +0300, Scott Wood 
> <scottwood@freescale.com>  wrote:
>> I don't think the workaround exists yet in arch/powerpc, despite the  
>> config option.
>>
> Is there a plan to be implemented on arch/powerpc, or devices with the  
> erratum will have to keep on using the legacy arch/ppc code?

I don't have any immediate plans to move it over (and I don't think I 
have easy access to affected hardware to test on); I can't speak for any 
plans others might have.  Patches are of course welcome. :-)

-Scott
