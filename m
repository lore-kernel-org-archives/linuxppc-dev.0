Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 8CBE4DDE23
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Feb 2007 01:09:25 +1100 (EST)
Message-ID: <45D31804.4050507@ru.mvista.com>
Date: Wed, 14 Feb 2007 17:09:08 +0300
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] powerpc: add of_get_mac_address() and update fsl_soc.c
	to use it
References: <1171408247467-git-send-email-timur@freescale.com>
	<1171411219.20192.118.camel@localhost.localdomain>
	<45D29B80.2060705@freescale.com>
In-Reply-To: <45D29B80.2060705@freescale.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: paulus@samba.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello.

Timur Tabi wrote:

>>> +    return get_property(np, "address", NULL);

>> Since there is so much room for confusion with "address", please at
>> least do some basic sanity checking, like check that it's size is 6
>> bytes and maybe that the multicast bit isn't set.

> Are you saying that some device trees have something *other* than a MAC 
> address in the 'address' property?

    'address' property was originally defined to hold a virtual address of the 
device registers (with 'reg' holding the physical address) until FSL decided 
to "reinvent" the property. :-)

WBR, Sergei
