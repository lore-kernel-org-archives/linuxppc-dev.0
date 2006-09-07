Return-Path: <AZeffertt@cambridgebroadband.com>
Received: from cambridgebroadband.com (mailhost.cambridgebroadband.com
	[217.204.121.83])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E7AA867BC1
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  8 Sep 2006 00:17:22 +1000 (EST)
Message-ID: <450029E3.2030303@cambridgebroadband.com>
Date: Thu, 07 Sep 2006 15:17:07 +0100
From: Alex Zeffertt <ajz@cambridgebroadband.com>
MIME-Version: 1.0
To: Li Yang-r58472 <LeoLi@freescale.com>
Subject: Re: MPC8360E USB Host Controller Driver
References: <4879B0C6C249214CBE7AB04453F84E4D14C7B2@zch01exm20.fsl.freescale.net>
In-Reply-To: <4879B0C6C249214CBE7AB04453F84E4D14C7B2@zch01exm20.fsl.freescale.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: n.balaji@gdatech.co.in, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Li Yang-r58472 wrote:
>> i have a MPC8347E running with the Freescale E(F)HCI driver 
>> and Kernel 2.6.17 (Freescale LTIB).
>>
>> Because of this mail, i checked, if there are any periodical 
>> interrupts, without real USB payload.
>>
>> The result is: NO
>>
>> If i attach a USB-mouse, i get 5 interrupts.
>> If i remove it again, 1 additional.
>>
>> Nothing else, silence !
>>
>> USB works well with USB 1.1 and 2.0 devices (This was not the 
>> case with earlier Kernels, e.g. 2.6.13, because for the 
>> switching between 1.1 and 2.0 you need a transaction 
>> translator driver).
> 
> MPC834x USB is very different from the USB of CPM/QE.  It is an
> integrated EHCI controller.
> 


So, the question is still open, does the QuiccEngine HCI (a.k.a. FHCI)
generate loading on the PPC core when there is no traffic on the USB?

Alex
