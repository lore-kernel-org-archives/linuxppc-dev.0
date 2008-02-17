Return-Path: <wg@grandegger.com>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 6687EDDE44
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 17 Feb 2008 23:28:17 +1100 (EST)
Message-ID: <47B8285C.40204@grandegger.com>
Date: Sun, 17 Feb 2008 13:28:12 +0100
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: Bruce_Leonard@selinc.com
Subject: Re: Frustrated question with insmod
References: <OF994170A6.977C29F1-ON882573F1.0005A6C7-882573F1.00060311@selinc.com>
In-Reply-To: <OF994170A6.977C29F1-ON882573F1.0005A6C7-882573F1.00060311@selinc.com>
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

Bruce_Leonard@selinc.com wrote:
> Sorry if this is the wrong place to post this question.  I'm developing a 
> NAND flash driver and I need to do some detailed dubugging using GDB with 
> a BDI2K.  According to the Denx web site, to find out the address that the 
> module is loading at you load it using the -m parameter to insmod (i.e., 
> "insmod -m mymodule").  However, every version of insmod I've tried 
> doesn't recognize ANY options much less -m.  Can anyone please point me in 
> the right direction, or give me another way of knowing what the load 
> address of my module is?

# cat /sys/module/<name>/sections/.text

Do not forget to enable CONFIG_KALLSYMS.

Wolfgang.
