Return-Path: <dale@farnsworth.org>
Received: from xyzzy.farnsworth.org (unknown [65.200.49.142])
	by ozlabs.org (Postfix) with SMTP id 4358967A6D
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 17 Jun 2005 13:37:14 +1000 (EST)
From: "Dale Farnsworth" <dale@farnsworth.org>
Date: Thu, 16 Jun 2005 20:37:12 -0700
To: Andrey Volkov <avolkov@varma-el.com>
Message-ID: <20050617033711.GA1362@xyzzy.farnsworth.org>
References: <Pine.OSF.4.05.10506161721010.24601-100000@da410.phys.au.dk>
	<42B1A214.404@varma-el.com>
	<528646bc05061610352d56cd49@mail.gmail.com>
	<42B1CB13.3060107@varma-el.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <42B1CB13.3060107@varma-el.com>
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

On Thu, Jun 16, 2005 at 10:55:15PM +0400, Andrey Volkov wrote:
> Grant Likely wrote:
> > On 6/16/05, Andrey Volkov <avolkov@varma-el.com> wrote:
> > 
> >>AFAIK almost all patches from http://www.246tnt.com/mpc52xx/ now in
> >>vanilla kernel. Except, bestcomm, certainly :(.
> > 
> > FEC is missing too.
> > 
> > Is anybody even working on bestcomm at the moment?
> It may be Dale Farnsworth or smb. quietly in Freescale.

I sent patches to Sylvain in August 2004 with 5200 FEC support,
including my rewrite of the bestcomm FEC code.  I've bugged him
about it a few times, and I don't know why he hasn't made it available.
I haven't done much with the 5200 since then.  I'm traveling now and
have some other pressing issues, but I'll try to post what
I have in the next couple of weeks.

-Dale
