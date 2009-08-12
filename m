Return-Path: <bj@mhlabs.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 56128B6EDE
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 12 Aug 2009 13:10:29 +1000 (EST)
Received: from mhsecure.serverpowered.net (mhsecure.serverpowered.net
	[204.8.182.18])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DF50ADDD01
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Aug 2009 13:10:27 +1000 (EST)
Message-Id: <421F78FD-E024-46DE-9882-37F216EB6EAC@mhlabs.com>
From: "B.J. Buchalter" <bj@mhlabs.com>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <835B2CCF-7189-499F-B0F5-527F2A788A77@kernel.crashing.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v935.3)
Subject: Re: Problem with PCIe -> PCI bridge on MPC8377E-RDB
Date: Tue, 11 Aug 2009 23:10:14 -0400
References: <4D3BDC67-986A-482D-BB3F-497F64C68531@mhlabs.com>
	<835B2CCF-7189-499F-B0F5-527F2A788A77@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Aug 11, 2009, at 9:43 PM, Kumar Gala wrote:

>
> On Aug 11, 2009, at 5:27 PM, B.J. Buchalter wrote:
>
>>
>> So it seems like the XIO2000(A) is being misconfigured or  
>> misidentified, and rather than finding the configured bus behind  
>> the bridge, it is doing "something else", and as a result, not  
>> finding the PCI OHCI FireWire controller on the PCI side of the  
>> bridge.
>>
>> Unfortunately I have no real idea where to start looking at this...
>>
>> Any ideas? Or is there a better place to be posting about this?
>
> This is a reasonable place to post this.  Can you see what u-boot  
> reports for its PCI/e bus scan?

Thanks,

This is what u-boot says:

U-Boot 1.3.3 (Jun 19 2008 - 10:47:48) MPC83XX

Reset Status: Software Hard, External/Internal Soft, External/Internal  
Hard

CPU:   e300c4, MPC8377E, Rev: 1.0 at 666.666 MHz, CSB: 333.333 MHz
Board: Freescale MPC837xERDB
I2C:   ready
DRAM:  256 MB
PCIE0: Link
PCIE1: No link
FLASH:  8 MB
NAND:  32 MiB
In:    serial
Out:   serial
Err:   serial
Net:   TSEC0, TSEC1
eSDHC: No SD/MMC card found
SATA:  SATA0 (No RDY)
        SATA1 (No RDY)
Hit any key to stop autoboot:  0
=> set serverip 10.0.1.40
=> run tftpnfsboot


If there is additional information to be found, I'd be happy to  
collect it.

Best regards,

B.J. Buchalter
	
