Return-Path: <sshtylyov@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id 292D4DDECE
	for <linuxppc-embedded@ozlabs.org>;
	Sun,  8 Apr 2007 22:17:08 +1000 (EST)
Message-ID: <4618DBEF.30307@ru.mvista.com>
Date: Sun, 08 Apr 2007 16:11:27 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: Flat device tree definitions for FLASH and MTD partitioning
References: <4618D400.8050003@grandegger.com>
In-Reply-To: <4618D400.8050003@grandegger.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
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

Hello.

Wolfgang Grandegger wrote:

> are there already some thought or even example code on how to define 
> Flash memory and MTD partitions in the DTS. This would avoid the ackward 
> MTD partitioning via static structure or boot line argument and could be 
> done in a generic way.

    See Documentation/powerpc/booting-without-of.txt and 
drivers/mtd/physmap_of.c for what's been already done.

> Thanks.
> 
> Wolfgang.

WBR, Sergei
