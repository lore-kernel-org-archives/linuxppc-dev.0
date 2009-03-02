Return-Path: <roland@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
	by ozlabs.org (Postfix) with ESMTP id 96380DDEEB
	for <linuxppc-dev@ozlabs.org>; Mon,  2 Mar 2009 12:44:54 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Roland McGrath <roland@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 2/2] x86-64: seccomp: fix 32/64 syscall hole
In-Reply-To: Linus Torvalds's message of  Saturday,
	28 February 2009 09:23:36 -0800
	<alpine.LFD.2.00.0902280916470.3111@localhost.localdomain>
References: <20090228030226.C0D34FC3DA@magilla.sf.frob.com>
	<20090228030413.5B915FC3DA@magilla.sf.frob.com>
	<alpine.LFD.2.00.0902271932520.3111@localhost.localdomain>
	<alpine.LFD.2.00.0902271948570.3111@localhost.localdomain>
	<20090228072554.CFEA6FC3DA@magilla.sf.frob.com>
	<alpine.LFD.2.00.0902280916470.3111@localhost.localdomain>
Message-Id: <20090302014423.22A6FFC3C6@magilla.sf.frob.com>
Date: Sun,  1 Mar 2009 17:44:23 -0800 (PST)
Cc: linux-mips@linux-mips.org, x86@kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, sparclinux@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>, stable@kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> And I guess the seccomp interaction means that this is potentially a 
> 2.6.29 thing. Not that I know whether anybody actually _uses_ seccomp. It 
> does seem to be enabled in at least Fedora kernels, but it might not be 
> used anywhere.

I have no idea who uses it.  I just assume that anyone who is using it
might be expecting it to be reliable for security purposes as advertised.


Thanks,
Roland
