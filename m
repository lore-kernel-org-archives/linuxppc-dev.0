Return-Path: <neko@genesi-usa.com>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.224])
	by ozlabs.org (Postfix) with ESMTP id 8991EDDE1B
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Oct 2008 09:08:31 +1000 (EST)
Received: by wx-out-0506.google.com with SMTP id s6so75802wxc.15
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Sep 2008 16:08:29 -0700 (PDT)
Message-ID: <48E2B16C.6030501@genesi-usa.com>
Date: Tue, 30 Sep 2008 18:08:28 -0500
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Gerald Van Baren <gvb.linuxppc.dev@gmail.com>
Subject: Re: Device Tree
References: <48E07490.9020805@enseirb.fr> <48E09108.4020400@ru.mvista.com>	
	<48E2444D.1050301@genesi-usa.com>
	<eee4c0020809301530w20d6d1e4sd2e3542366cc595d@mail.gmail.com>
In-Reply-To: <eee4c0020809301530w20d6d1e4sd2e3542366cc595d@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: Matt Sealey <neko@genesi-usa.com>
Cc: =?UTF-8?B?aHLDqXRpZW4=?= <chretien@enseirb.fr>,
	=?UTF-8?B?U8OpYmFzdGllbiBD?=, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Gerald Van Baren wrote:
> Matt Sealey wrote:
 >>
>> The Toshiba TOPAS910 ARM development board also runs Open Firmware and
>> contains patches to support OF device trees.
>>
>> I dare say there might be an x86 box or two out there, too. But they
>> have ACPI tables too which is far more common..
> 
> More than a box or two: lots of OLPC XOs out there now.  ;-)
>     <http://wiki.laptop.org/go/Open_Firmware>

I was thinking more in a platform kind of numbers rather than a sales
kind of numbers, but you're right.

It's far more common than people might think at first glance. With x86
I am sure it would benefit the platform a little more if the OF support
was in-line with the shared code between PPC and SPARC (and now I guess,
ARM) but nevertheless it's an Open Firmware platform and something that
appeared not too long ago.

OF is still a going concern; if you want a nice flexible firmware, why
not use it? Most of the implementations are open source (FirmWorks and
CodeGen trees, and the Sun reference design) too.

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations
