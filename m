Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1FAC4DDE1C
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Sep 2007 09:01:51 +1000 (EST)
Message-ID: <46FC3645.70303@freescale.com>
Date: Thu, 27 Sep 2007 18:01:25 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: michael@ellerman.id.au
Subject: Re: [PATCH v4] Make instruction dumping work in real mode.
References: <20070927183855.GA18226@loki.buserror.net>
	<1190933846.6601.1.camel@concordia>
In-Reply-To: <1190933846.6601.1.camel@concordia>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Michael Ellerman wrote:
> On Thu, 2007-09-27 at 13:38 -0500, Scott Wood wrote:
>> On non-book-E-or-4xx, exceptions execute in real mode.  If a fault happens
>> that leads to a register dump, the kernel currently prints XXXXXXXX because
>> it doesn't realize that PC is a physical address.
>>
>> This patch checks the state of the IMMU, and if necessary converts PC into a
>> virtual address.
> 
> IMMU ?

Instruction Memory Management Unit.

-Scott
