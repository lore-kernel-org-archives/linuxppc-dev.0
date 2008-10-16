Return-Path: <mark@bish.net>
Received: from vincent.bish.net (bish.net [209.241.232.100])
	by ozlabs.org (Postfix) with ESMTP id B738BDE05A
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 17 Oct 2008 06:38:54 +1100 (EST)
Received: from www-data by vincent.bish.net with local (Exim 4.63)
	(envelope-from <mark@bish.net>) id 1KqXqg-00036s-5P
	for linuxppc-embedded@ozlabs.org; Thu, 16 Oct 2008 14:45:27 -0400
Message-ID: <20081016144526.tjuq1t5mgw4ks4co@www.bish.net>
Date: Thu, 16 Oct 2008 14:45:26 -0400
From: Mark Bishop <mark@bish.net>
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1;
	DelSp="Yes";
	format="flowed"
Subject: How can I make flash writeable?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I am using the MPC8313E-RDB and I am having some problems using the  
flash that comes on the board.  Let me preface this by saying that I  
haven't worked in the embedded linux arena in about 10 years so I am  
trying to catch up with all the new toys.

This board uses uBoot and it currently has 128M of DDR2, 8M flash and  
32M NAND Flash.  I have a few questions:

How can I tell which memory device it uses to boot out of?
How can I tell which devices are mapped to /proc/mtd devices?


I want to create a writeable flash partition, is there a FAQ out there  
I could look at.

All of this is after a few days of using Google to try and glean some  
data from the internet.  And the books don't get here from Amazon  
until Monday.

I would appreciate any help.  Even a RTFM - if you could point me to  
TFM, it would greatly help.
