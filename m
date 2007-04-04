Return-Path: <david.lang@digitalinsight.com>
Received: from warden.diginsite.com (warden-p.diginsite.com [208.29.163.248])
	by ozlabs.org (Postfix) with SMTP id E018CDDEF3
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Apr 2007 11:41:34 +1000 (EST)
Date: Tue, 3 Apr 2007 18:07:06 -0700 (PDT)
From: David Lang <david.lang@digitalinsight.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Stop pmac_zilog from abusing 8250's device numbers.
In-Reply-To: <20070404022828.5c9b97f3@the-village.bc.nu>
Message-ID: <Pine.LNX.4.63.0704031804350.21680@qynat.qvtvafvgr.pbz>
References: <1175644642.10567.31.camel@shinybook.infradead.org><200704032210
	02.GA13210@cynthia.pants.nu><1175648051.10567.61.camel@shinybook.infradead.
	org><20070403.181645.68159458.davem@davemloft.net>
	<20070404022828.5c9b97f3@the-village.bc.nu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, paulus@samba.org,
	dwmw2@infradead.org, David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 4 Apr 2007, Alan Cox wrote:

>> I don't need to know anything about the inanrds of my computer to
>> bring up the ethernet interface, me caveman me bringup eth0, me on
>> network, caveman happy.  The same should be true for serial ports.
>
> You don't get machines with 64 ethernet ports on add-in cards. There are
> good reasons for the naming schemes in use.

I've seen machines offering up to 48, what's the magic number that makes you 
need to chagne nameing schemes?

I also know of systems with 50 serial ports on them. the fact that some of the 
serial ports on the front panel were named differently then other serial ports 
on the front panel sure didn't make my life easier in dealing with them.

David Lang
