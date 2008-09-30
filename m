Return-Path: <neko@genesi-usa.com>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.179])
	by ozlabs.org (Postfix) with ESMTP id D9B9DDE292
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Oct 2008 01:22:56 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m33so35273wag.9
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Sep 2008 08:22:55 -0700 (PDT)
Message-ID: <48E2444D.1050301@genesi-usa.com>
Date: Tue, 30 Sep 2008 10:22:53 -0500
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: Device Tree
References: <48E07490.9020805@enseirb.fr> <48E09108.4020400@ru.mvista.com>
In-Reply-To: <48E09108.4020400@ru.mvista.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: Matt Sealey <neko@genesi-usa.com>
Cc: =?UTF-8?B?U8OpYmFzdGllbiBDaHLDqXRpZW4=?= <chretien@enseirb.fr>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Sergei Shtylyov wrote:
> Hello.
> 
> Sébastien Chrétien wrote:
>> Hello,
>> I have a question about Device Tree.
>> Is Device Tree found only only on Linux Powerpc ?
> 
>   Not only Linux as it's a part of Open Firmware which is also used at 
> least on SPARC.

The Toshiba TOPAS910 ARM development board also runs Open Firmware and
contains patches to support OF device trees.

I dare say there might be an x86 box or two out there, too. But they
have ACPI tables too which is far more common..

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations
