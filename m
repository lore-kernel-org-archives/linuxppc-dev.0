Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao02.cox.net (fed1rmmtao02.cox.net [68.230.241.37])
	by ozlabs.org (Postfix) with ESMTP id 5F2E967DA9
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 28 Jul 2005 03:15:05 +1000 (EST)
Date: Wed, 27 Jul 2005 10:15:03 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Michael Richardson <mcr@sandelman.ottawa.on.ca>,
	Kumar Gala <galak@freescale.com>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org,
	linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Message-ID: <20050727101502.B1114@cox.net>
References: <Pine.LNX.4.61.0507271029480.12237@nylon.am.freescale.net>
	<1271.1122480803@marajade.sandelman.ottawa.on.ca>
	<20050727162741.GC28681@gate.ebshome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050727162741.GC28681@gate.ebshome.net>;
	from ebs@ebshome.net on Wed, Jul 27, 2005 at 09:27:41AM -0700
Subject: Re: [PATCH 00/14] ppc32: Remove board ports that are no longer
	maintained
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, Jul 27, 2005 at 09:27:41AM -0700, Eugene Surovegin wrote:
> On Wed, Jul 27, 2005 at 12:13:23PM -0400, Michael Richardson wrote:
> > Kumar, I thought that we had some volunteers to take care of some of
> > those. I know that I still care about ep405, and I'm willing to maintain
> > the code.
> 
> Well, it has been almost two months since Kumar asked about maintenance 
> for this board. Nothing happened since then.
> 
> Why is it not fixed yet? Please, send a patch which fixes it. This is 
> the _best_ way to keep this board in the tree, not some empty 
> maintenance _promises_.

When we recover our history from the linuxppc-2.4/2.5 trees we can
show exactly how long it's been since anybody touched ep405.

Quick googling shows that it's been almost 2 years since the last
mention of ep405 (exluding removal discussions) on linuxppc-embedded.
Last ep405-related commits are more than 2 years ago.

-Matt
