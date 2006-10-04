Return-Path: <aleck@gdatech.com>
Received: from darwaza.gdatech.com (darwaza.gdatech.com [66.237.41.98])
	by ozlabs.org (Postfix) with ESMTP id CD84567C6C
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  4 Oct 2006 12:24:37 +1000 (EST)
Received: from spamcheck.gdatech.com (localhost.localdomain [127.0.0.1])
	by spamcheck.gdatech.com (Postfix-out) with ESMTP id D92E86AC072
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  3 Oct 2006 19:24:37 -0700 (PDT)
Received: from sierra.gdatech.com (sierra.gdatech.com [192.168.200.112])
	by spamcheck.gdatech.com (Postfix-out) with ESMTP id 9FE006AC068
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  3 Oct 2006 19:24:37 -0700 (PDT)
Received: from monstertop ([192.168.10.172]) (authenticated)
	by sierra.gdatech.com (8.11.6/8.11.6) with ESMTP id k942P3n04022
	for <linuxppc-embedded@ozlabs.org>; Tue, 3 Oct 2006 19:25:03 -0700
From: "Aleck Lin" <aleck@gdatech.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: platform flash for Xilinx ML403
Date: Tue, 3 Oct 2006 19:24:28 -0700
Message-ID: <003001c6e75c$3ad7da70$800101df@monstertop>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <mailman.5.1159927227.32514.linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello,

Can anyone help with my questions on platform flash for Xilinx ML403? 

>From what I understand, I can use platform flash to store my FPGA bitstream
file and my software application elf file, so it's like using an ACE file
through the CompactFlash, except I just need to set the configuration
address through DIP switch and then push the PROG button on the board
(provided it's set to Platform Flash mode) and then the software application
would start running. Is this correct?

If it's correct, then how would I be able to program the Platform Flash? Do
I program separate bit file and elf file, or do I program an ace file or ??
I have the ML40x Getting Started Tutorial in which there's a section on how
to program my own flash image. But I couldn't really understand some things
in it, such as a PROM file, or adding file to Revision no. and etc. Can
someone help or point out a more detailed document? 

My eventual goal is to be able to use the platform flash to start u-boot and
then boot linux image, which will be stored in linear flash. I think I have
all the parts ready (u-boot image, uImage, and hardware bitstream), but just
lack of the understanding to put in this particular configuration.

Any help would be appreciated!

Thanks,

Aleck
