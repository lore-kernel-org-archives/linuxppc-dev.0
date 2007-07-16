Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 96382DDEE3
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 00:28:54 +1000 (EST)
In-Reply-To: <68D5EA7E-30DF-4856-8526-BABEFE230C05@kernel.crashing.org>
References: <1184082728.20129.187.camel@localhost.localdomain>
	<963D5B48-F1E5-4930-9F29-98D7F0E33C0A@kernel.crashing.org>
	<1184121840.22066.24.camel@localhost.localdomain>
	<0E17851B-A642-43E2-9A5D-39DFC6F30E77@kernel.crashing.org>
	<7431AAFD-73B7-4337-94CB-878285D298E3@kernel.crashing.org>
	<1184228873.27622.11.camel@localhost.localdomain>
	<2EA16557-7960-4A1A-9D07-BDA3D8843460@kernel.crashing.org>
	<1184240183.28074.113.camel@localhost.localdomain>
	<68D5EA7E-30DF-4856-8526-BABEFE230C05@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <3F1CA06C-23E3-44EC-8A6E-E16BF690F664@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [patch 3/6] Add 8548 CDS PCI express controller node and PCI-X
	device node
Date: Mon, 16 Jul 2007 09:29:10 -0500
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jul 16, 2007, at 8:05 AM, Segher Boessenkool wrote:

>>> is this the only fix, I've already applied a version of this to my
>>> tree (with the irq sense fix) and just want to make sure there isn't
>>> anything else.
>> I do not get more.
>> I'd like to enroll Segher's suggestion together with VIA chip  
>> function
>> in next step.
>> We need to make basic pcie work on 8548 CDS board first.
>
> If you can, please make the "compatible" properties correct
> ("pcie" instead of "pciex") before the patch goes in; it'll
> be less work total and less confusing in the end.

I've taken care of that as well.

They are now 'fsl,mpc8548-pcie, and 'fsl,mpc8641-pcie'

- k
