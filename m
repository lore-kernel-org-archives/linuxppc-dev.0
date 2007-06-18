Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18038.6658.854660.4233@cargo.ozlabs.ibm.com>
Date: Mon, 18 Jun 2007 15:37:06 +1000
From: Paul Mackerras <paulus@samba.org>
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH] Wire up sys_sync_file_range() on powerpc
In-Reply-To: <1182018044.2808.75.camel@pmac.infradead.org>
References: <1181992681.25228.683.camel@pmac.infradead.org>
	<1182018044.2808.75.camel@pmac.infradead.org>
Cc: akpm@osdl.org, linuxppc-dev@ozlabs.org, torvalds@osdl.org,
	rmk@arm.linux.org.uk, linux-arch@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Woodhouse writes:

> Pants.

Ah.  Is that a naughty word in the UK?  If so I'll have to remember
that when I go to kernel summit. :)

> It doesn't work because the 'flags' argument ends up in r9, and
> we can only use r3-r8 for syscall arguments. We'll need to do it the
> same way as ARM does, with the flags as the second argument.

Yes.  We'll need a wrapper for both 32-bit and for 32-on-64.

> Or is it? Can we ditch sys_sync_file_range now and implement a new
> sys_sync_file_range2 with the two 32-bit arguments first?

Would be nice...

Paul.
