Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9682F67C7C
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Aug 2006 17:08:43 +1000 (EST)
In-Reply-To: <7EA18FDD2DC2154AA3BD6D2F22A62A0E26E5CF@zch01exm23.fsl.freescale.net>
References: <7EA18FDD2DC2154AA3BD6D2F22A62A0E26E5CF@zch01exm23.fsl.freescale.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <06073868-B8CB-428A-8E57-70B436A0268B@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH ] powerpc:  pass UPIO_TSI flag to 8259 serial driver
Date: Wed, 23 Aug 2006 02:08:33 -0500
To: "Zang Roy-r61911" <tie-fei.zang@freescale.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>,
	Yang Xin-Xin-r48390 <Xin-Xin.Yang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Aug 23, 2006, at 1:27 AM, Zang Roy-r61911 wrote:

>>
>> On Aug 22, 2006, at 9:20 PM, Zang Roy-r61911 wrote:
>>
>>> The patch passes the UPIO_TSI flag to general 8259 serial driver
>>>
>>> Signed-off-by: Roy Zang	<tie-fei.zang@freescale.com>
>>
>> Maybe, I'm missing something, but why do we need this?  Why
>> doesn't iotype == UPIO_MEM work for the TSI?
>>
>> - kumar
>>
>
> Tsi108 serial port has some difference from the standard 8250 port.
>  I add UPIO_TSI in general 8250 serial driver to handle IIR and IER
> register
> in serial_in and serial_out.

Gotcha, that makes sense now.

- k
