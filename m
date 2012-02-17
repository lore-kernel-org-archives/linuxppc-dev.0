Return-Path: <sam@ravnborg.org>
Date: Fri, 17 Feb 2012 19:05:38 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v5 00/27] irq_domain generalization and rework
Message-ID: <20120217180538.GA11520@merkur.ravnborg.org>
References: <1329383368-12122-1-git-send-email-grant.likely@secretlab.ca>
 <20120216145219.0f1c1b98.akpm@linux-foundation.org>
 <20120216232648.GM27825@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120216232648.GM27825@n2100.arm.linux.org.uk>
Cc: devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Milton Miller <miltonm@bga.com>, Rob Herring <rob.herring@calxeda.com>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> > 
> > /*
> >  * Please do not include this file in generic code.  There is currently
> >  * no requirement for any architecture to implement anything held
> >  * within this file.
> >  *
> >  * Thanks. --rmk
> >  */
> > 
> > A quick grep indicates that we've lost this battle ;) Is the comments
> > still true?  Should we stop discouraging inclusion of linux/irq.h? 
> > Does anyone even know that it's discouraged ;)
> 
> It's still true for any platform which hasn't been converted to genirq,
> as such a platform would not have asm/hw_irq.h.

In-tree only s390 is not using genirq.
All the rest are converted and provide hw_irq.h -
most of the new archs provide hw_irq via asm-generic so it does
not show up unless you look in the Kbuild file,.

	Sam
