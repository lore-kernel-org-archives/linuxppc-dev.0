Return-Path: <tnt@246tNt.com>
Received: from outfbmx002.isp.belgacom.be (outfbmx002.isp.belgacom.be
	[195.238.3.102]) by ozlabs.org (Postfix) with ESMTP id 233D22BE83
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 22 Nov 2004 07:12:52 +1100 (EST)
Received: from outmx014.isp.belgacom.be (outmx014.isp.belgacom.be
	[195.238.2.69]) by outfbmx002.isp.belgacom.be
	(8.12.11/8.12.11/Skynet-OUT-FALLBACK-2.22) with ESMTP id
	iALGBLug013916
	for <linuxppc-embedded@ozlabs.org>; Sun, 21 Nov 2004 17:11:21 +0100
	(envelope-from <tnt@246tNt.com>)
Received: from outmx014.isp.belgacom.be (localhost [127.0.0.1])
	by outmx014.isp.belgacom.be (8.12.11/8.12.11/Skynet-OUT-2.22) with
	ESMTP id iALGB3cn002933
	for <linuxppc-embedded@ozlabs.org>; Sun, 21 Nov 2004 17:11:03 +0100
	(envelope-from <tnt@246tNt.com>)
Message-ID: <41A0BE13.5000302@246tNt.com>
Date: Sun, 21 Nov 2004 17:10:59 +0100
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: roger blofeld <blofeldus@yahoo.com>
References: <20041119145354.59388.qmail@web53507.mail.yahoo.com>
In-Reply-To: <20041119145354.59388.qmail@web53507.mail.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Lite5200 FEC Driver on linux 2.6 broken? (fixed again)
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

roger blofeld wrote:

>>What tree are you exactly using ?
>>In mainstream XLB snooping is not configured so if you have the 
>>mainstream + added DMA,
>>the problem may come from this.
>>
>>
>>   Sylvain
>>    
>>
>
>I did a bk clone of the linux-2.5 tree (2.6.10-rc2), then a bk pull of
>your tree. You're probably right about the snooping. Since the driver
>is working at the moment, I'll wait until your tree is updated before
>doing more testing.
>Thanks
>-rb
>  
>
Wow, that must have led to a bunch of conflicts no ?

Now, it's more up-to-date and cloning mainstream and pulling should be ok.
Note that my tree is now :

bk://bkbits.246tNt.com/linux-2.5-mpc52xx

(no -devel, I merged the two in only one)

The flush_dcache_range is not present because if it still fails I'd like 
to understand why.
I should not be needed or maybe I'm missing something. If still doesn't 
work, I'll
add it with a note.


    Sylvain
