Return-Path: <mingo@elte.hu>
Received: from mx2.mail.elte.hu (mx2.mail.elte.hu [157.181.151.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 97B8E67C13
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Oct 2006 00:41:34 +1000 (EST)
Date: Wed, 18 Oct 2006 16:33:18 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Daniel Walker <dwalker@mvista.com>
Subject: Re: [PATCH -rt] powerpc update
Message-ID: <20061018143318.GB25141@elte.hu>
References: <20061003155358.756788000@dwalker1.mvista.com>
	<20061018072858.GA29576@elte.hu>
	<1161181941.23082.32.camel@c-67-180-230-165.hsd1.ca.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1161181941.23082.32.camel@c-67-180-230-165.hsd1.ca.comcast.net>
Cc: linuxppc-dev@ozlabs.org, tglx@linutronix.de, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


* Daniel Walker <dwalker@mvista.com> wrote:

> On Wed, 2006-10-18 at 09:28 +0200, Ingo Molnar wrote:
> > * Daniel Walker <dwalker@mvista.com> wrote:
> > 
> > > Pay close attention to the fasteoi interrupt threading. I added usage 
> > > of mask/unmask instead of using level handling, which worked well on 
> > > PPC.
> > 
> > this is wrong - it should be doing mask+ack.
> 
> The main reason I did it this way is cause the current threaded eoi 
> expected the line to be masked. So if you happen to have a eoi that's 
> threaded you get a warning then the interrupt hangs.

does that in fact happen on -rt6? If yes, could you send the warning 
that is produced?

	Ingo
