Return-Path: <steve@icarus.com>
Received: from icarus.com (icarus.icarus.com [64.105.89.2])
	by ozlabs.org (Postfix) with ESMTP id 7E7C52BC0F
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 27 Oct 2004 06:59:30 +1000 (EST)
Received: from icarus.com (wing [192.168.1.7]) (authenticated)
	by icarus.com (8.11.6/8.11.6) with ESMTP id i9QKxQe28325
	for <linuxppc-embedded@ozlabs.org>; Tue, 26 Oct 2004 13:59:26 -0700
Message-ID: <417EBAAE.5080603@icarus.com>
Date: Tue, 26 Oct 2004 13:59:26 -0700
From: Stephen Williams <steve@icarus.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
References: <1098701468l.31592l.0l@ipnnarval>
	<417D2B5E.8050200@xilinx.com>	<35fb2e59041025140776cfe174@mail.gmail.com>
	<417DE312.6070405@xilinx.com>
In-Reply-To: <417DE312.6070405@xilinx.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: Re: uboot and ppc405
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Peter Ryser wrote:

>> btw Peter, I've been moaning about the weird interrupt behaviour of
>> the SysACE on e.g. the Memec board for some time (see archives for
>> various other people's experiences too) - and I've spoken to several
>> folks at Xilinx without getting very far. If there's a fundamental
>> problem then it probably makes sense for us to help get it fixed.
>>
> Hmm, I'm not aware of any interrupt problems with System ACE CF. For 
> Linux it works for a long time unchanged as published in the 
> linuxppc_2_4_devel and linuxppc-2.4 repositories. I'm operating my own 
> web and mail server on a V2P based board using a 1GB MicroDrive through 
> System ACE CF as the root and swap filesystems. The system is up and 
> running for months now. No special tricks or hacks just a 
> straight-forward EDK FPGA design with a MVL kernel.

The SystemACE in the linuxppc-2.4 kernel works fine for me on
our JSE board. We keep a lightly used ext3 partition for root,
and a FAT partition in the beginning for boot and ACE files.
The Xilinx HAL, though ugly as sin, has not given us trouble.

We use a PPC405GPr with the SystemACE connected to a peripheral
bus. No VIIPro here. this is surely different from the ML300,
yet it works.

-- 
Steve Williams                "The woods are lovely, dark and deep.
steve at icarus.com           But I have promises to keep,
http://www.icarus.com         and lines to code before I sleep,
http://www.picturel.com       And lines to code before I sleep."
