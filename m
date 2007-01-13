Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 73463DDE49
	for <linuxppc-dev@ozlabs.org>; Sun, 14 Jan 2007 07:56:36 +1100 (EST)
In-Reply-To: <45A91C92.4030504@am.sony.com>
References: <200701120100.l0C10ktW025821@toshiba.co.jp>	<20070113124638.GA13493@krispykreme>
	<06ebc2a1b06cafb9aaa3bcf8407db1fe@kernel.crashing.org>
	<45A91C92.4030504@am.sony.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <87ad2655e255adfd416e6b4f5f7dd0ac@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 7/19] powerpc: interfaces to the hypervisor of Celleb
Date: Sat, 13 Jan 2007 21:57:04 +0100
To: Geoff Levand <geoffrey.levand@am.sony.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org,
	Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> Or just write "sc 1", everyone should have new enough binutils
>> by now.
>
> The option to 'sc' came in binutils-2.17, but I from what I 
> understand, debian
> stable doesn't have it, so I used a similar construction for ps3.

Oh sorry, I thought it was in 2.16 for a long time already.  If
Debian doesn't have it, well sigh, let's use .long 0x44000022
for a bit longer :-(


Segher
