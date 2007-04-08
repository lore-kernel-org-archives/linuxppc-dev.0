Return-Path: <wg@grandegger.com>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 6EF86DDEEC
	for <linuxppc-embedded@ozlabs.org>;
	Sun,  8 Apr 2007 22:39:12 +1000 (EST)
Message-ID: <4618E2E0.1070307@grandegger.com>
Date: Sun, 08 Apr 2007 14:41:04 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: Flat device tree definitions for FLASH and MTD partitioning
References: <4618D400.8050003@grandegger.com> <4618DBEF.30307@ru.mvista.com>
	<4618DE4A.4020404@ru.mvista.com>
In-Reply-To: <4618DE4A.4020404@ru.mvista.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Sergei Shtylyov wrote:
> Hello, I wrote:
> 
>>> are there already some thought or even example code on how to define 
>>> Flash memory and MTD partitions in the DTS. This would avoid the 
>>> ackward MTD partitioning via static structure or boot line argument 
>>> and could be done in a generic way.
> 
>>     See Documentation/powerpc/booting-without-of.txt and 
>> drivers/mtd/physmap_of.c for what's been already done.
> 
>    I meant drivers/mtd/maps/physmap_of.c

Ah, I missed that, thanks a lot.

Wolfgang.
