Return-Path: <miltonm@bga.com>
Received: from ruth.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id 76943DDFEE
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Jun 2007 05:13:33 +1000 (EST)
Mime-Version: 1.0 (Apple Message framework v624)
In-Reply-To: <18034.6787.951861.623265@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <e59440a6d0ba1def65d264966798799b@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: for-2.6.23 branch in powerpc.git created
Date: Fri, 15 Jun 2007 14:13:42 -0500
To: Paul Mackerras <paulus@samba.org>
Cc: ppcdev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul,

Please add "kexec: send slaves to new kernel earlier" It should
apply offset about 40 lines.

http://patchwork.ozlabs.org/linuxppc/patch?id=10399

I've updated my kexec zImage support to 2.6.22-rc4 and made some
fixes, so I'll resend those.  The Makefile diffs always break, so
I might wait until you merge some of the other pending boot patches.

milton
