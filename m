Return-Path: <zippel@linux-m68k.org>
Received: from scrub.xs4all.nl (scrub.xs4all.nl [194.109.195.176])
	by ozlabs.org (Postfix) with ESMTP id 664A367B6C
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Dec 2006 08:57:14 +1100 (EST)
From: Roman Zippel <zippel@linux-m68k.org>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] 2.6.18-rt7: fix more issues with 32-bit cycles_t
	=?iso-8859-1?q?in=09latency=5Ftrace=2Ec?= (take 3)
Date: Mon, 4 Dec 2006 22:56:50 +0100
References: <200611132252.58818.sshtylyov@ru.mvista.com>
	<4574149B.5070602@ru.mvista.com> <20061204153949.GA9350@elte.hu>
In-Reply-To: <20061204153949.GA9350@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200612042256.51823.zippel@linux-m68k.org>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, dwalker@mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

On Monday 04 December 2006 16:39, Ingo Molnar wrote:

> there's *always* a way to do such things more cleanly - such as the
> patch below. Could you try to fix it up for 32-bit cycles_t platforms? I
> bet the hackery will be limited to now() and maybe the conversion
> routines, instead of spreading all around latency_trace.c.

While I'm not against this patch, but on m68k I prefer a 32bit cycle type 
(however it's called), so it doesn't solve the original problem.

bye, Roman
