Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C504467C54
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Jul 2005 08:36:29 +1000 (EST)
In-Reply-To: <20050713214802.68288.qmail@web61016.mail.yahoo.com>
References: <20050713214802.68288.qmail@web61016.mail.yahoo.com>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <17068cbdcbb1e2de531d33eb07f768e5@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Wed, 13 Jul 2005 15:36:13 -0700
To: ming lei <mlei30@yahoo.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: double kernel page table entry for the same physical page?!
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Jul 13, 2005, at 2:48 PM, ming lei wrote:

> Why linux kernel does such thing and no one consider
> it's a problem?

Because we don't write software that accesses the memory
from both of those locations, unless it is very intentional
and necessary.  If you are just fishing for ways software
_could_ do bad things, there are tons of them.  It's our
job to write it so it doesn't :-)

Thanks.


	-- Dan
