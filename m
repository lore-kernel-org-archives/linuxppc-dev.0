Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18475.48822.311219.341385@cargo.ozlabs.ibm.com>
Date: Thu, 15 May 2008 14:40:22 +1000
From: Paul Mackerras <paulus@samba.org>
To: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 0/2] ftrace ported to PPC
In-Reply-To: <20080515034942.109223655@goodmis.org>
References: <20080515034942.109223655@goodmis.org>
Cc: proski@gnu.org, a.p.zijlstra@chello.nl, pq@iki.fi,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	sandmann@redhat.com, Ingo Molnar <mingo@elte.hu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Steven Rostedt writes:

> The following two patches ports ftrace to PowerPC. I tested this on
> both my PPC64 box as well as my 32bit PowerBook G4.

Very cool!  Thanks.

> This applies to the latest sched-devel (with some extra hacks to get that
> to boot on PPC).
> 
> This also depends on the CFLAGS_REMOVE_foo.o patches I sent earlier.

Ingo, when do you intend to send the ftrace stuff to Linus?  In the
next merge window?

Paul.
