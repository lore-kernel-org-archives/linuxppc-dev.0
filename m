Return-Path: <rusty@rustcorp.com.au>
From: Rusty Russell <rusty@rustcorp.com.au>
To: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH 4/7] hvc_console: Fix race between hvc_close and hvc_remove
Date: Thu, 8 Apr 2010 09:56:32 +0930
References: <20100319151326.GC8541@kroah.com>
	<20100326124340.GB7039@amit-x200.redhat.com>
	<20100406114238.GN5594@kryten>
In-Reply-To: <20100406114238.GN5594@kryten>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201004080956.33405.rusty@rustcorp.com.au>
Cc: a.p.zijlstra@chello.nl, Greg Kroah-Hartman <gregkh@suse.de>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Amit Shah <amit.shah@redhat.com>, tglx@linutronix.de,
	Linus Torvalds <torvalds@linux-foundation.org>, mingo@elte.hu,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 6 Apr 2010 09:12:38 pm Anton Blanchard wrote:
> The patch below changes things to call tty_kref_put once for every
> hvc_close call, and with that my machine boots fine.

Thanks, applied.

Cheers,
Rusty.
