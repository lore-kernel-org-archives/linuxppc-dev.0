Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6F282DDE28
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Sep 2008 07:45:31 +1000 (EST)
Date: Tue, 23 Sep 2008 14:30:57 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: johannes@sipsolutions.net
Subject: Re: [Bugme-new] [Bug 11629] New: quad G5 fails to shut down
Message-Id: <20080923143057.e3e54536.akpm@linux-foundation.org>
In-Reply-To: <bug-11629-10286@http.bugzilla.kernel.org/>
References: <bug-11629-10286@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Thomas, Ingo Molnar <mingo@elte.hu>,
	Gleixner <tglx@linutronix.de>, bugme-daemon@bugzilla.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 23 Sep 2008 14:20:55 -0700 (PDT)
bugme-daemon@bugzilla.kernel.org wrote:

> http://bugzilla.kernel.org/show_bug.cgi?id=11629
> 
>            Summary: quad G5 fails to shut down
>            Product: Platform Specific/Hardware
>            Version: 2.5
>      KernelVersion: 2.6.27-rc6+wireless bits
>           Platform: All
>         OS/Version: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: normal
>           Priority: P1
>          Component: PPC-64
>         AssignedTo: anton@samba.org
>         ReportedBy: johannes@sipsolutions.net
> 
> 
> Latest working kernel version: don't remember, pretty sure 2.6.26 worked but
> have been running development kernels forever
> Earliest failing kernel version: n/a, haven't checked, has been failing for a
> while
> Distribution: debian/unstable
> Hardware Environment: quad G5 powermac
> Software Environment: ?
> Problem Description: machine fails to shut down, 
> 
> Steps to reproduce:
> shut down the machine, see it fail.
> 
> http://johannes.sipsolutions.net/files/dsc_2274.jpg
> 

That went splat in the clockevents code.

I saw a pull request with several fixes float past this morning:

From: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>
Subject: [git pull] timer fixes
Date: Tue, 23 Sep 2008 21:41:00 +0200

Fingers crossed..

I'll mark this as a post-2.6.26 regression, although you seem a bit
wobbly on that.
