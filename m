Return-Path: <tglx@linutronix.de>
Received: from www.tglx.de (www.tglx.de [62.245.132.106])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id F058FB6EEC
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 13 Oct 2010 03:56:56 +1100 (EST)
Date: Tue, 12 Oct 2010 18:56:23 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Andi Kleen <andi@firstfloor.org>
Subject: Re: [RFC] [PATCH] allow low HZ values?
In-Reply-To: <871v7v32kn.fsf@basil.nowhere.org>
Message-ID: <alpine.LFD.2.00.1010121854430.2909@localhost6.localdomain6>
References: <20101011201121.GA953@tpepper-t61p.dolavim.us>
	<alpine.LFD.2.00.1010112227190.2909@localhost6.localdomain6>
	<871v7v32kn.fsf@basil.nowhere.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Marcio Saito <marcio@cyclades.com>, "H. Peter Anvin" <hpa@zytor.com>,
	Jiri Slaby <jirislaby@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
	John Stultz <johnstul@us.ibm.com>, x86@kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Tim Pepper <lnxninja@linux.vnet.ibm.com>, jblunck@infradead.org,
	Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>,
	Frederic Weisbecker <fweisbec@gmail.com>,
	Avantika Mathur <mathur@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 12 Oct 2010, Andi Kleen wrote:
> Thomas Gleixner <tglx@linutronix.de> writes:
> > We have told HPC folks for years that we need a kind of "NOHZ" mode
> > for HPC where we can transparently switch off the tick when only one
> > user space bound thread is active and switch back to normal once this
> > thing terminates or goes into the kernel via a syscall. Sigh, nothing
> > happened ever except for repeating the same crap patches over and
> > over.
> 
> Jan Blunck posted a patch for this exactly few months ago.
> Unfortunately it didn't get the accounting right, but other than
> that it seemed like a reasonable starting point.

Unfortunately it did not get a lot of other things right either.

Thanks,

	tglx
