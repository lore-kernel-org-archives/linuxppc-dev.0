Return-Path: <tnt@246tNt.com>
Received: from outmx016.isp.belgacom.be (outmx016.isp.belgacom.be
	[195.238.4.115])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 49D8ADDE45
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  8 Mar 2007 23:21:48 +1100 (EST)
Received: from outmx016.isp.belgacom.be (localhost [127.0.0.1])
	by outmx016.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id l28CLeG4022685
	for <linuxppc-embedded@ozlabs.org>; Thu, 8 Mar 2007 13:21:41 +0100
	(envelope-from <tnt@246tNt.com>)
Message-ID: <45EFFFA5.7080004@246tNt.com>
Date: Thu, 08 Mar 2007 13:20:53 +0100
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: Oliver Rutsch <orutsch@sympatec.com>
Subject: Re: MPC5200, PLX9054 PCI Card - stalled DMA transfers
References: <45E6CAC8.8090007@sympatec.com> <45E75859.3090508@ovro.caltech.edu>
	<45EFBF91.7080304@sympatec.com>
In-Reply-To: <45EFBF91.7080304@sympatec.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


>> Anyway, manually setup a DMA transfer and convince yourself that
>> you know which bits to twiddle, then figure out why the driver
>> code isn't doing as its asked.
>>
>>     
>
> I've done so without success. The driver seems to make everything 
> correct. A block DMA is fairly simple on the 9054, so I think there must 
> be a hardware reason for this.
> Has anybody ever used a PCI card on the MPC5200 which has its own 
> busmaster controller? I think most people use the BestComm DMA 
> controller on the MPC5200, right?
>   
No, most PCI card that need big xfer uses bus mater. A ide card, a
network card, ...  all most certainly use it.

Bestcomm on the 5200 is for the SoC internal peripheral mainly.


Sylvain
