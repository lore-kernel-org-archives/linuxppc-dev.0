Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 76F9268896
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 15 Dec 2005 01:30:41 +1100 (EST)
In-Reply-To: <43A028DB.5090906@ru.mvista.com>
References: <1134555662.439ff20e6e812@webmail.televes.com:443>
	<43A0021E.7030406@ru.mvista.com>
	<1134569602.43a0288234662@webmail.televes.com:443>
	<43A028DB.5090906@ru.mvista.com>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <386A8114-FA1C-44E2-A8F1-CF48F4AF495E@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Date: Wed, 14 Dec 2005 08:30:48 -0600
To: Vitaly Bordug <vbordug@ru.mvista.com>
Cc: linuxppc-embedded list <linuxppc-embedded@ozlabs.org>,
	Alex BASTOS <alebas@televes.com>
Subject: Re: [SOLVED] Re: pq2_find_bridges hangs system
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Dec 14, 2005, at 8:14 AM, Vitaly Bordug wrote:

> Alex BASTOS wrote:
>> Vitaly,
>>> Maybe, but I guess more correct is to deal with USB->PCI  
>>> dependency..
>>> Is it really needed(I am not USB expert)?
>> Neither am I. I guess for this Host Controler it is not needed at
>> HW level, but I am not sure why it is still required by the SW.
>>>> 3) I have seen that from u-boot, a reset occurs when I read  
>>>> Internal
>>>> Memory at offset 0x10904 (PCI CFG_DATA). From BDI, when I do the  
>>>> same
>>>> all PCI section on IM becomes zero. Is this a known behaviour?  
>>>> May this
>>>> reflect a hardware problem?
>>>>
>>> Sounds weird
>> Here is the problem. The cause for this weird behaviour is that I
>> had PCI_ARBITER_EN_  disabled. So, a HW problem at the end.
>> I had disabled it trying to reduce power compsumption due to the PCI,
>> as I am not going to use it. It seems it is not possible that way.
>> Any idea how to get this done?

I'm guessing you dont have anything else doing arbitration on the bus.

- kumar
