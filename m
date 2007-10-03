Return-Path: <timur@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7B043DDE0A
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Oct 2007 00:16:58 +1000 (EST)
Message-ID: <4703A453.8080305@freescale.com>
Date: Wed, 03 Oct 2007 09:16:51 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH v3] qe: miscellaneous code improvements and fixes to	the
	QE library
References: <11903212461510-git-send-email-timur@freescale.com>
	<20071003133032.GA2417@localhost.localdomain>
In-Reply-To: <20071003133032.GA2417@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Anton Vorontsov wrote:
> Hi Timur,
> 
> On Thu, Sep 20, 2007 at 03:47:26PM -0500, Timur Tabi wrote:
>> This patch makes numerous miscellaneous code improvements to the QE library.
> 
> ...and also breaks MPC8568E-MDS. ;-) Board hangs just after ip-config stuff.
> 
> Commit 589ffa1c520355e37d5868 in galak/powerpc.git.
> 
> Unfortunately it isn't split, thus it will take time to track faulty bit.
> But so far... maybe you have any ideas?

No.  The changes are supposed to be completely transparent.  I did have to 
modify the ucc_geth driver because of a change in some QE library functions, 
but I tested it on 8360 and it works there.

It could be something peripheral, like a general breakdown of the QE itself on 
85xx.

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
