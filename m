Return-Path: <stefanr@s5r6.in-berlin.de>
Received: from einhorn.in-berlin.de (einhorn.in-berlin.de [192.109.42.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.vr.in-berlin.de",
	Issuer "IN-Berlin Server CA (G2)" (not verified))
	by ozlabs.org (Postfix) with ESMTP id D4FC167BC3
	for <linuxppc-dev@ozlabs.org>; Sun,  3 Sep 2006 09:32:38 +1000 (EST)
Message-ID: <44FA1386.9030400@s5r6.in-berlin.de>
Date: Sun, 03 Sep 2006 01:28:06 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
MIME-Version: 1.0
To: Wolfgang Pfeiffer <roto@gmx.net>
Subject: Re: Broken Firewire 400/SCSI on ppc Powerbook5,8
References: <20060817230347.GC3440@localhost> <20060818234930.GB2662@localhost>
	<44E6D634.3000207@s5r6.in-berlin.de>
	<20060823002801.GA2709@localhost> <20060824192200.GA2715@localhost>
	<44F9D8EF.6010101@s5r6.in-berlin.de>
	<20060902230858.GA2814@localhost>
In-Reply-To: <20060902230858.GA2814@localhost>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, billfink@mindspring.com,
	linux1394-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Wolfgang Pfeiffer wrote:
> On Sat, Sep 02, 2006 at 09:18:07PM +0200, Stefan Richter wrote:
[...]
>> you could test the AluBook running Linux and TiBook 
>> in target disk mode again to exclude the possibility of problems at the 
>> AluBook's side. Use "hdparm -tT /dev/sda" to try a few actual block read 
>> operations. 
> 
> I do not have to mount /dev/sda for the test. Correct? 

That's right. This works on the block IO level, not via filesystem. It 
is not even necessary to detect any partitions to run this test. On the 
other hand, it is not very thorough because only about 50...100 MB will 
be read. (You could also read from sda with dd or the like.)

[...]
> The only frustrating thing for me is my lacking
> knowledge when it comes to understand code like the one on the
> kernel.org page below ..

That's because it's extremely ugly code. Guess why it's buggy. :-) It's 
just a debug printk though.

[...]
> Please let me know if I can help with tests if you want to patch
> ohci1394.

Thanks, I will Cc you.
-- 
Stefan Richter
-=====-=-==- =--= ---==
http://arcgraph.de/sr/
