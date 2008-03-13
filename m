Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A70A5DDF54
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Mar 2008 08:36:32 +1100 (EST)
Date: Thu, 13 Mar 2008 14:35:10 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Roland McGrath <roland@redhat.com>
Subject: Re: [PATCH -mm 1/4] powerpc copy_siginfo_from_user32
Message-Id: <20080313143510.9cfb7ab4.akpm@linux-foundation.org>
In-Reply-To: <20080313083107.8BDE926F992@magilla.localdomain>
References: <20080313083107.8BDE926F992@magilla.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, paulus@samba.org,
	anton@samba.org, mingo@elte.hu, tglx@linutronix.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Problems.

> Subject: [PATCH -mm 1/4] powerpc copy_siginfo_from_user32

This is advertised as a -mm patch but afacit it isn't against -mm.  And it
doesn't seem to be against mainline either?  At least, the fourth patch
fails to apply.

When trying to apply the fourth patch to -mm I hit a reject due to the new
BTS support in git-x86.  I stopped there because the patch might be invalid
because of this.

On Thu, 13 Mar 2008 01:31:07 -0700 (PDT)
Roland McGrath <roland@redhat.com> wrote:

> 
> Define the copy_siginfo_from_user32 entry point for powerpc, so
> that generic CONFIG_COMPAT code can call it.  We already had the
> code rolled into compat_sys_rt_sigqueueinfo, this just moves it
> out into the canonical function that other arch's define.
> 

Even though this appears to be a signal-related patch it is actually
ptrace-related, yes?

This patch is a prerequisite for "ptrace: compat_ptrace_request siginfo",
but this patch is independent from that patch (and from all others) and
hence this patch can be merged on its own into powerpc tree if we wish to go that
way, yes?  (Although probably it would be better not to do it that way, for
sanity's sake).


Anwyay, please help me out with the dependencies here, and take a look at
the x86 BTS stuff?

Thanks.
