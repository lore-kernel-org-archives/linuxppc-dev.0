Return-Path: <hpa@zytor.com>
Received: from terminus.zytor.com (terminus.zytor.com [192.83.249.54])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5D883DDE3E
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Apr 2007 02:09:03 +1000 (EST)
Message-ID: <4613CD34.8080509@zytor.com>
Date: Wed, 04 Apr 2007 09:07:16 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
To: David Lang <david.lang@digitalinsight.com>
Subject: Re: [PATCH] Stop pmac_zilog from abusing 8250's device numbers.
References: <1175644642.10567.31.camel@shinybook.infradead.org><200704032210
	02.GA13210@cynthia.pants.nu><1175648051.10567.61.camel@shinybook.infradead.
	org><20070403.181645.68159458.davem@davemloft.net><20070404022828.5c9b97f3@
	the-village.bc.nu><Pine.LNX.4.63.0704031804350.21680@qynat.qvtvafvgr.pbz>
	<20070404024400.56d016e1@the-village.bc.nu>
	<Pine.LNX.4.63.0704031817020.21680@qynat.qvtvafvgr.pbz>
In-Reply-To: <Pine.LNX.4.63.0704031817020.21680@qynat.qvtvafvgr.pbz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, paulus@samba.org,
	dwmw2@infradead.org, David Miller <davem@davemloft.net>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Lang wrote:
> On Wed, 4 Apr 2007, Alan Cox wrote:
> 
>>>> You don't get machines with 64 ethernet ports on add-in cards. There 
>>>> are
>>>> good reasons for the naming schemes in use.
>>>
>>> I've seen machines offering up to 48, what's the magic number that 
>>> makes you
>>> need to chagne nameing schemes?
>>
>> Have you tried working with 48 ports when they are not numbered 0-47 or
>> in some logical fashion ?
> 
> no, but that's what we're wanting with serial ports as well. a system 
> with 50 serial ports should have them numbered 0-49, not typea0-5, 
> typeb0-39, typec0-5
> 

I would actually disagree.  I have systems with multiport serial cards 
installed, and I much prefer those to be named differently.  Not only do 
I not have to worry about the same problem I *constantly* have with 
onboard Ethernet cards -- whoops I just installed an expansion card and 
suddenly my onboard NIC is eth2! -- but the expansion serial ports tend 
to be *different.*

For example, on my serial server, the Cyclades ports (ttyC*) use RJ-45 
connections from an external expansion module, whereas of course the 
builtin ones (ttyS*) use DB-9s.

	-hpa
