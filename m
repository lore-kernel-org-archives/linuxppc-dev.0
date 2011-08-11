Return-Path: <schwab@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id 1AD4FB6F64
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Aug 2011 18:45:46 +1000 (EST)
From: Andreas Schwab <schwab@redhat.com>
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Subject: Re: [RFC] Optimize __arch_swab32 and __arch_swab16
References: <OF9F5D0B06.A12659DA-ONC12578E9.002B23BB-C12578E9.002D304C__34569.7653633126$1313050887$gmane$org@transmode.se>
Date: Thu, 11 Aug 2011 10:45:42 +0200
In-Reply-To: <OF9F5D0B06.A12659DA-ONC12578E9.002B23BB-C12578E9.002D304C__34569.7653633126$1313050887$gmane$org@transmode.se>
	(Joakim Tjernlund's message of "Thu, 11 Aug 2011 10:13:34 +0200")
Message-ID: <m34o1ouyix.fsf@hase.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Joakim Tjernlund <joakim.tjernlund@transmode.se> writes:

> unsigned short my__arch_swab16(unsigned short value)
> {
> 	__asm__("rlwimi %0,%0,16,0x00ff0000"
> 		: "+r" (value));

You are creating a value that does not fit in a short.

Andreas.

-- 
Andreas Schwab, schwab@redhat.com
GPG Key fingerprint = D4E8 DBE3 3813 BB5D FA84  5EC7 45C6 250E 6F00 984E
"And now for something completely different."
