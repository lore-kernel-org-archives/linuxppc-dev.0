Return-Path: <jsteve17@yahoo.com>
Received: from web33408.mail.mud.yahoo.com (web33408.mail.mud.yahoo.com
	[68.142.206.140]) by ozlabs.org (Postfix) with SMTP id DDC4E67BB0
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 22 Sep 2006 11:11:27 +1000 (EST)
Message-ID: <20060922010445.20750.qmail@web33408.mail.mud.yahoo.com>
Date: Thu, 21 Sep 2006 18:04:44 -0700 (PDT)
From: Jeff Stevens <jsteve17@yahoo.com>
Subject: Linux not booting consistantly
To: linuxppc-embedded@ozlabs.org
In-Reply-To: <004001c6dddb$19df51c0$0b01a8c0@shenbagaraj>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I have a custom AMCC 440SP board, with 1GB DDR2, and
32MB of flash.  I am having an issue with the linux
kernel, where I can get it to boot every once and a
while by power-cycling or pressing the reset button,
the rest of the time it hangs after uncompressing the
kernel:

## Booting image at 00200000 ...
   Image Name:   Linux-2.6.15
   Image Type:   PowerPC Linux Kernel Image (gzip
compressed)
   Data Size:    1067371 Bytes =  1 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK

  Could this be a memory issue (i.e. bad memory
configuration)?  Though, if it were a memory issue,
wouldn't the kernel fail to uncompress successfully?
Does anyone have any ideas why it would work about
once every 10 - 20 resets?

Thanks,
   Jeff Stevens



__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
