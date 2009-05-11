Return-Path: <dhlii@dlasys.net>
Received: from outbound-mail-32.bluehost.com (outbound-mail-32.bluehost.com
	[69.89.18.152]) by ozlabs.org (Postfix) with SMTP id A9254DDDA1
	for <linuxppc-dev@ozlabs.org>; Tue, 12 May 2009 02:58:39 +1000 (EST)
Message-ID: <4A08593C.4010503@dlasys.net>
Date: Mon, 11 May 2009 12:58:36 -0400
From: "David H. Lynch Jr." <dhlii@dlasys.net>
MIME-Version: 1.0
To: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
Subject: Re: device trees.
References: <4A0457BC.3040408@dlasys.net>
	<fa686aa40905091351k140c64a0w27eb44908218814@mail.gmail.com>
	<1242007203.7767.28.camel@concordia>
	<fa686aa40905102108l5c964893y2dfb84763e13511@mail.gmail.com>
	<4A07C664.6040609@dlasys.net>
	<fa686aa40905110651r1c18b78bpe8ffebe041726695@mail.gmail.com>
	<20090511155232.A30671B6005D@mail89-va3.bigfish.com>
In-Reply-To: <20090511155232.A30671B6005D@mail89-va3.bigfish.com>
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Stephen Neuendorffer wrote:
>> You *could* generate the device tree dynamically, but I think that is
>> a path of diminishing returns considering that generating a .dts at
>> the same time as bitstream creation time is cheap and it is small.  At
>> one time Steven Neuendorffer was playing with a scheme to preload a
>> section of BRAM with a gzipped .dtb so that the correct device tree is
>> always present.  I really liked the idea, and I'd like to try to
>> pursue it.
>>     
Thanks and I will look at it.
But if you want my .02, append the .dtb to the bit file in some fashion
that it can easily be located.
We already use all the bram we are willing to steal from clients (16k)
for our monitor/boot loader.

>
> In fact, the code to do this should still be floating around
> git.xilinx.com, although someone would likely have to bring it up to the
> current kernel versions.
> My intention was to treat it as two independent configuration options:
>
> 1) .dtb location is in BRAM
> 2) .dtb is passed compressed (regardless of location)
>
> Steve
>
> This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
>
>
>   


-- 
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       dhlii@dlasys.net 	  http://www.dlasys.net
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too numerous to list.

"Any intelligent fool can make things bigger and more complex... It takes a touch of genius - and a lot of courage to move in the opposite direction."
Albert Einstein
