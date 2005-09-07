Return-Path: <jeff@theptrgroup.com>
Received: from mail.theptrgroup.com (unknown [209.183.211.17])
	by ozlabs.org (Postfix) with ESMTP id E9A1F681ED
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  7 Sep 2005 23:59:22 +1000 (EST)
From: Jeff Angielski <jeff@theptrgroup.com>
To: glikely@gmail.com
In-Reply-To: <528646bc050906112673dd4543@mail.gmail.com>
References: <528646bc050906112673dd4543@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 07 Sep 2005 09:56:08 -0400
Message-Id: <1126101368.8521.25.camel@nighteyes.site>
Mime-Version: 1.0
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: Xilinx SystemACE driver for 2.6
Reply-To: jeff@theptrgroup.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, 2005-09-06 at 18:26 +0000, Grant Likely wrote:
> Has anybody ported the SystemACE driver from 2.4 to 2.6 yet?  If so,
> where can I pull a patch from?  Otherwise I'll start work on it.

Along these lines, has anybody done any work to improve the overall
performance of the driver?

What kind of throughput are you seeing on your systems?

With our 266MHz MPC8260 w/ SystemACE (DENX linux-2.4.25), we see the
following numbers from Bonnie 1.4.  The first set is for an ext2 system
and the second is for ext3...

---Sequential Output (nosync)--- ---Sequential Input-- --Rnd Seek-
-Per Char- --Block--- -Rewrite-- -Per Char- --Block--- --04k (03)-
MB K/sec %CPU K/sec %CPU K/sec %CPU K/sec %CPU K/sec %CPU   /sec %CPU
  
     696 65.9  1638  5.7   367  1.6   438 47.6   868  1.7   59.5  5.4

     540 53.4   901  9.4   355  1.8   495 54.1   862  1.6   52.4  3.0



Jeff Angielski
The PTR Group
