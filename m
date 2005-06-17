Return-Path: <dale@farnsworth.org>
Received: from xyzzy.farnsworth.org (unknown [65.200.49.142])
	by ozlabs.org (Postfix) with SMTP id 96CA6679E6
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 18 Jun 2005 00:00:41 +1000 (EST)
From: "Dale Farnsworth" <dale@farnsworth.org>
Date: Fri, 17 Jun 2005 07:00:30 -0700
To: Andrey Volkov <avolkov@varma-el.com>
Message-ID: <20050617140022.GA15877@xyzzy.farnsworth.org>
References: <Pine.OSF.4.05.10506161721010.24601-100000@da410.phys.au.dk>
	<42B1A214.404@varma-el.com>
	<528646bc05061610352d56cd49@mail.gmail.com>
	<42B1CB13.3060107@varma-el.com>
	<20050617033711.GA1362@xyzzy.farnsworth.org>
	<42B2A5C7.1040909@varma-el.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <42B2A5C7.1040909@varma-el.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: MPC5200/Lite5200 and ethernet
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, Jun 17, 2005 at 02:28:23PM +0400, Andrey Volkov wrote:
> > I sent patches to Sylvain in August 2004 with 5200 FEC support,
> > including my rewrite of the bestcomm FEC code.  I've bugged him
> > about it a few times, and I don't know why he hasn't made it available.
> > I haven't done much with the 5200 since then.  I'm traveling now and
> > have some other pressing issues, but I'll try to post what
> > I have in the next couple of weeks.
> > 
> > -Dale
> 
> Dale, don't worry, Sylvain public your patches in himself src tree
> (http://www.246tnt.com/mpc52xx/) at August/September,2004.
> But, after that, OCP infra was dropped in kernel, and, hence, this
> driver was not sent to Andrew Morton (Bestcomm stuff, until now, OCP
> depended). And no one find time to convert Bestcomm to platform bus
> model :(.
> 
> I planned start this job at July/August, so if someone wish to do it NOW
> (June) - welcome.

Thank you Andrey, and my apologies to Sylvain.  I didn't realize that
they were available.  I'll take a look at converting to the platform bus
model, but it will be at least a week before I start.

-Dale
