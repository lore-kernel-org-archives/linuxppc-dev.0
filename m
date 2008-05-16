Return-Path: <mingo@elte.hu>
Received: from mx2.mail.elte.hu (mx2.mail.elte.hu [157.181.151.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4A5BDDDF1D
	for <linuxppc-dev@ozlabs.org>; Fri, 16 May 2008 22:06:01 +1000 (EST)
Date: Fri, 16 May 2008 14:05:35 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 0/2] ftrace ported to PPC
Message-ID: <20080516120535.GB11718@elte.hu>
References: <20080515034942.109223655@goodmis.org>
	<18475.48822.311219.341385@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <18475.48822.311219.341385@cargo.ozlabs.ibm.com>
Cc: proski@gnu.org, a.p.zijlstra@chello.nl, pq@iki.fi,
	linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>, linuxppc-dev@ozlabs.org,
	sandmann@redhat.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


* Paul Mackerras <paulus@samba.org> wrote:

> Steven Rostedt writes:
> 
> > The following two patches ports ftrace to PowerPC. I tested this on 
> > both my PPC64 box as well as my 32bit PowerBook G4.
> 
> Very cool!  Thanks.

great - could you please send an Acked-by line for those patches?

> > This applies to the latest sched-devel (with some extra hacks to get 
> > that to boot on PPC).
> > 
> > This also depends on the CFLAGS_REMOVE_foo.o patches I sent earlier.
> 
> Ingo, when do you intend to send the ftrace stuff to Linus?  In the 
> next merge window?

yeah, that's the plan, this merge window was too hot already. Right now 
there's an ftrace topic in the -tip tree:

    http://people.redhat.com/mingo/tip.git/README

that contains the latest ftrace patches. Please holler if you see 
something weird in it.

	Ingo
