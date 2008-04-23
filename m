Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18446.50037.964682.539009@cargo.ozlabs.ibm.com>
Date: Wed, 23 Apr 2008 15:04:53 +1000
From: Paul Mackerras <paulus@samba.org>
To: Roland McGrath <roland@redhat.com>
Subject: Re: [PATCH] powerpc TLF_RESTORE_SIGMASK
In-Reply-To: <20080403210842.6C88C26F98D@magilla.localdomain>
References: <20080403210842.6C88C26F98D@magilla.localdomain>
Cc: linuxppc-dev@ozlabs.org, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Roland McGrath writes:

> This requires the earlier HAVE_SET_RESTORE_SIGMASK patch series.
> This does the same for powerpc that I posted the x86 change for.

...

> +static inline void set_restore_sigmask(void)
> +{
> +	struct thread_info *ti = current_thread_info();
> +	ti->local_flags |= TLF_RESTORE_SIGMASK;

This should be _TLF_RESTORE_SIGMASK (leading '_'), I think.

Paul.
