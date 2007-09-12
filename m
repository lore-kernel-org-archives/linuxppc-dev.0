Return-Path: <geoffrey.levand@am.sony.com>
Received: from mgw2.sony.co.jp (MGW2.Sony.CO.JP [137.153.0.14])
	by ozlabs.org (Postfix) with ESMTP id EDAFDDDDFA
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Sep 2007 12:19:39 +1000 (EST)
Received: from mail35.sony.co.jp (localhost [127.0.0.1])
	by mail35.sony.co.jp (R8/Sony) with ESMTP id l8C2JbCl010408
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Sep 2007 11:19:37 +0900 (JST)
Received: from mailgw02.scei.sony.co.jp (mailgw02.scei.sony.co.jp [43.27.73.8])
	by mail35.sony.co.jp (R8/Sony) with SMTP id l8C2JbDJ010402
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Sep 2007 11:19:37 +0900 (JST)
Message-ID: <46E74C95.3090402@am.sony.com>
Date: Tue, 11 Sep 2007 19:19:01 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH] powerpc: add new required termio functions
References: <8018.1189562679@neuling.org>
In-Reply-To: <8018.1189562679@neuling.org>
Content-Type: text/plain; charset=UTF-8
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, paulus@samba.org,
	Alan Cox <alan@redhat.com>, akpm@linux-foundation.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Michael Neuling wrote:
> The "tty: termios locking functions break with new termios type" patch
> (f629307c857c030d5a3dd777fee37c8bb395e171) breaks the powerpc compile.
> This adds the required API to asm-powerpc.
> 
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> --
> This needs to go up for 2.6.23.
> 
> Should we really put these definitions in asm-generic/termios.h as I'm
> guessing other architectures are broken too?

I think it would be better to do so, as that is where we pickup the defs for
the original kernel_termios_to_user_termios and user_termios_to_kernel_termios.

-Geoff
