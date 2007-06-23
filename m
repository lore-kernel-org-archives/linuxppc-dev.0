Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound6-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 6C4AEDDE35
	for <linuxppc-dev@ozlabs.org>; Sun, 24 Jun 2007 05:25:12 +1000 (EST)
Message-ID: <467D7386.2070005@am.sony.com>
Date: Sat, 23 Jun 2007 12:24:54 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [patch 23/33] powerpc: Localize mmu_off
References: <20070615204749.629571012@am.sony.com>	<46730D5B.300@am.sony.com>
	<18039.31697.402356.570828@cargo.ozlabs.ibm.com>
In-Reply-To: <18039.31697.402356.570828@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul Mackerras wrote:
> Geoff Levand writes:
> 
>> This just removes the dependency __mmu_off has on the symbol
>> __after_prom_start.  I found the current code inconvenient when I
>> wanted to put some debugging code between the call to __mmu_off
>> and the branch to __after_prom_start.
> 
> So we do an extra unnecessary branch...  I realize it doesn't really
> matter, but on the other hand, if you're hacking around with debug
> stuff, you can easily change __after_prom_start to the label where
> your debug code starts.

Sure, I don't really care about this one, so let's drop it.

-Geoff
