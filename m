Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id 8E71DB7CF8
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Jan 2010 07:48:59 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: Is it normal when kernel printed "xxx used greatest stack depth"
Date: Thu, 28 Jan 2010 21:35:47 +0100
References: <389deec71001280753n2df39d98m4b8c60f971a29bc7@mail.gmail.com>
In-Reply-To: <389deec71001280753n2df39d98m4b8c60f971a29bc7@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201001282135.47372.arnd@arndb.de>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, hank peng <pengxihan@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thursday 28 January 2010, hank peng wrote:
> On my MPC8548 based board, sometimes kernel printed out the following
> messages, I wonder if it indicates the system is not normal?
> 
> pdflush used greatest stack depth: 4048 bytes left
> pdflush used greatest stack depth: 4028 bytes left
> pdflush used greatest stack depth: 3964 bytes left
> pdflush used greatest stack depth: 3916 bytes left

It's a debug option that you have enabled in the kernel configuration.
3916 bytes left is not unusual, there is nothing to worry here,
but on production systems, you might want to disable
CONFIG_DEBUG_STACK_USAGE.

	Arnd
