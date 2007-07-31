Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7F813DDE02
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  1 Aug 2007 00:13:41 +1000 (EST)
In-Reply-To: <9F3F0A752CAEBE4FA7E906CC2FBFF57C06A2A4@MERCURY.inside.istor.com>
References: <9F3F0A752CAEBE4FA7E906CC2FBFF57C06A2A4@MERCURY.inside.istor.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <E784DA5F-50B0-4B3A-99F6-6F13AF98BF1F@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: I2C interrupts on 8541
Date: Tue, 31 Jul 2007 09:14:46 -0500
To: Charles Krinke <ckrinke@istor.com>
Cc: Mark Freedkin <mfreedkin@istor.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Jul 30, 2007, at 11:51 AM, Charles Krinke wrote:

> I'm puzzled about how to setup interrupts for the second I2C interface
> in an 8541. This is the CPM interface, the one with buffer  
> descriptors.
>
> I see mention of its I2CER/I2CMR registers, but am having trouble
> figuring out how to enable and interrupt so that when the interface is
> in slave mode and a packet is received, it will vector to an interrupt
> service routine.
>
> I am using Linux-2.7.17.11 and I know you-all have gone past this a  
> bit,
> but in the midst of a project, we are constrained to finish with the
> kernel we started with.
>
> A few pointers on enabling an interrupt from this interface would be
> greatly appreciated.

To get interrupts you need to use the BD rings.  Look at the section  
'I2C Buffer Descriptors' in the 8555 UM and it shows 'I' bits in both  
the TX & RX rings that should cause interrupts.

- k
