Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18706.51381.987014.370948@cargo.ozlabs.ibm.com>
Date: Thu, 6 Nov 2008 21:36:37 +1100
From: Paul Mackerras <paulus@samba.org>
To: Andreas Schwab <schwab@suse.de>
Subject: Re: [PATCH] Fix msr check in compat_sys_swapcontext
In-Reply-To: <jey6zx9piz.fsf@sykes.suse.de>
References: <jeprlabbi6.fsf@sykes.suse.de>
	<18706.16317.759662.855430@cargo.ozlabs.ibm.com>
	<jey6zx9piz.fsf@sykes.suse.de>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Andreas Schwab writes:

> Paul Mackerras <paulus@samba.org> writes:
> 
> > we need to use get_user, not __get_user, since we haven't done an
> > access_ok() check on the address.
> 
> The address is always ok since its a compat pointer, see do_setcontext.

OK, since it's inside a CONFIG_PPC64 block.  I'll add a paragraph to
the patch description pointing that out.

Paul.
