Return-Path: <paubert@iram.es>
Received: from gra-lx1.iram.es (gra-lx1.iram.es [150.214.224.41])
	by ozlabs.org (Postfix) with ESMTP id CE001DE048
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Sep 2008 02:22:57 +1000 (EST)
From: Gabriel Paubert <paubert@iram.es>
Date: Tue, 23 Sep 2008 17:53:58 +0200
To: Srinivasa Ds <srinivasa@in.ibm.com>
Subject: Re: [RFC][PATCH] Demultiplexing SIGTRAP signal -v2
Message-ID: <20080923155358.GA15776@iram.es>
References: <200809221602.32616.srinivasa@in.ibm.com>
	<20080923112812.GL29021@elte.hu> <20080923113001.GA12531@elte.hu>
	<200809231955.01564.srinivasa@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200809231955.01564.srinivasa@in.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-parisc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	paulus@samba.org, "H. Peter Anvin" <hpa@zytor.com>,
	Ingo Molnar <mingo@elte.hu>, akpm@linux-foundation.org,
	Roland McGrath <roland@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Sep 23, 2008 at 07:55:01PM +0530, Srinivasa Ds wrote:
> On Tuesday 23 September 2008 17:00:01 Ingo Molnar wrote:
> 
> > > applied to [the new topic] tip/core/signal, thanks Srinivasa! There
> > > are some other pending x86 signal changes already, so i based
> > > tip/core/signal on tip/x86/signal.
> >
> > -tip testing found the following build error with the attached config:
> >
> 
> Ingo, Reproduced build break issue with your config on tip tree. It was a costly overlook 
> to miss one header file. I included it in this patch and tested it out.
> 
> 
> Currently a SIGTRAP can denote any one of below reasons.
> 	- Breakpoint hit
> 	- H/W debug register hit
> 	- Single step
> 	- Signal sent through kill() or rasie()

Typo: s/rasie/raise/

No strong opinion about the patch, but more info is usually better.

	Regards,
	Gabriel
