Return-Path: <ben@trinity.fluff.org>
Received: from trinity.fluff.org (trinity.fluff.org [89.16.178.74])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9F90410086F
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 13 Jan 2010 01:44:39 +1100 (EST)
Date: Tue, 12 Jan 2010 14:24:04 +0000
From: Ben Dooks <ben-linux@fluff.org>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC,PATCH 1/7 v2] Add a common struct clk
Message-ID: <20100112142404.GD18532@trinity.fluff.org>
References: <1263279511.160551.332624337260.1.gpush@pororo>
	<4B4C376C.6080705@st.com>
	<20100112090149.GB26435@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100112090149.GB26435@n2100.arm.linux.org.uk>
Cc: Francesco VIRLINZI <francesco.virlinzi@st.com>,
	Jeremy Kerr <jeremy.kerr@canonical.com>,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jan 12, 2010 at 09:01:49AM +0000, Russell King - ARM Linux wrote:
> On Tue, Jan 12, 2010 at 09:48:44AM +0100, Francesco VIRLINZI wrote:
> > Hi Jeremy
> > In November I already sent a proposal on
> >  a generic linux clk framework.
> > On that I would suggest:
> >
> >>
> >> +struct clk {
> >> +	const struct clk_operations *ops;
> >>    
> >            spinlock_t lock;
> >            const char *name;
> >            int id;
> 
> Name and ID are totally pointless, unless you insist on using the clk
> API in the wrong way (like S3C does.)

I do intend to change the clock lookup on the Samsung series, but we're
currently in the process of trying to do a whole pile of work on not
only adding new SoCs but also cleaning up the existing support and making
a whole pile of code common to all the Samsung SoC family.

I never got the time to go throughly through Francesco's clock framework
but it seemed rathe rcomplicated for our current requirements and also
had a whole pile of style problems that made it really difficult to read.

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
