Return-Path: <kyle@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [18.85.46.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 347C0DDDA9
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Apr 2009 00:56:57 +1100 (EST)
Date: Thu, 2 Apr 2009 09:56:40 -0400
From: Kyle McMartin <kyle@mcmartin.ca>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: [PATCH 0/7] Generic RTC class driver
Message-ID: <20090402135640.GA14159@bombadil.infradead.org>
References: <1236605183-22718-1-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<alpine.LRH.2.00.0903111134270.1040@vixen.sonytel.be>
	<20090311154505.GB5448@bombadil.infradead.org>
	<alpine.LRH.2.00.0903111825040.1040@vixen.sonytel.be>
	<20090313042543.GA3907@bombadil.infradead.org>
	<alpine.LRH.2.00.0904021141080.30882@vixen.sonytel.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.LRH.2.00.0904021141080.30882@vixen.sonytel.be>
Sender: Kyle McMartin <kyle@infradead.org>
Cc: linux-m68k@vger.kernel.org, Kyle McMartin <kyle@infradead.org>,
	linux-parisc@vger.kernel.org, rtc-linux@googlegroups.com,
	Paul Mundt <lethal@linux-sh.org>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>,
	Kyle McMartin <kyle@mcmartin.ca>,
	Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	Alessandro Zummo <alessandro.zummo@towertech.it>,
	Andrew Morton <akpm@linux-foundation.org>, Dann Frazier <dannf@dannf.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Apr 02, 2009 at 11:42:02AM +0200, Geert Uytterhoeven wrote:
> On Fri, 13 Mar 2009, Kyle McMartin wrote:
> > On Wed, Mar 11, 2009 at 06:26:12PM +0100, Geert Uytterhoeven wrote:
> > > On Wed, 11 Mar 2009, Kyle McMartin wrote:
> > > > On Wed, Mar 11, 2009 at 11:36:02AM +0100, Geert Uytterhoeven wrote:
> > > > > Is it OK for you to take it through your PA-RISC tree?
> > > > > If yes, I can resend the patch series with the collected acks.
> > > > 
> > I've pulled it and pushed it back out, I'll submit it when the merge
> > window opens.
> 
> Apparently the first half went it through akpm. Will you take care of the
> remaining commits?
> 

Yup, I updated the rtc-parisc branch last night, I'll push it along to
Linus this morning.

Thanks again, Geert.

cheers, Kyle
