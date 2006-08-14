Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17631.62940.63888.908937@cargo.ozlabs.ibm.com>
Date: Mon, 14 Aug 2006 14:02:36 +1000
From: Paul Mackerras <paulus@samba.org>
To: "Albert Cahalan" <acahalan@gmail.com>
Subject: Re: [PATCH] no-execute -- please test
In-Reply-To: <787b0d920608132020q4ad2b5c2y49e25ca7ecc33536@mail.gmail.com>
References: <787b0d920608132020q4ad2b5c2y49e25ca7ecc33536@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org, debian-powerpc <debian-powerpc@lists.debian.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Albert Cahalan writes:

> If you want heap protection, change VM_DATA_DEFAULT_FLAGS32
> in include/asm-powerpc/page.h to be like VM_STACK_DEFAULT_FLAGS.
> I'd love to hear if anybody can get X to start with this change.

In general I would expect dynamically-linked programs to fail unless
you compile everything with gcc -msecure-plt.

Paul.
