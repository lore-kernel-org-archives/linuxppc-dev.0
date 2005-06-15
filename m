Return-Path: <vbordug@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (RT-soft-2.Moscow.itn.ru [80.240.96.70])
	by ozlabs.org (Postfix) with SMTP id 75761679E1
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 15 Jun 2005 17:55:44 +1000 (EST)
Message-ID: <42AFDEFE.2040508@ru.mvista.com>
Date: Wed, 15 Jun 2005 11:55:42 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
MIME-Version: 1.0
To: Kumar Gala <galak@freescale.com>
References: <1118773086.29515.10.camel@dell2650.onz.com>
	<Pine.LNX.4.61.0506142231040.2447@nylon.am.freescale.net>
In-Reply-To: <Pine.LNX.4.61.0506142231040.2447@nylon.am.freescale.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: RFC: cpm2_devices.c
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Kumar,
I assume this as a IMMR enumerating you promised to help with. Is it in 
the final state? And what was the reason of fcc_regs_c removal?
I'm also going to change the files name to cpm2_.. .
Allen,
I'll provide a patch containing these platform stuff together with 
platform-specific device structures which is utilized in the fs_enet 
driver. As now it's clear that fcc_mem dpram offset should be passed 
over platform_info, these structures at least regarding fs_enet probably 
will not change.

--
Sincerely, Vitaly
