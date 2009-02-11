Return-Path: <ben@fluff.org.uk>
Received: from kira.home.fluff.org (aeryn.fluff.org.uk [87.194.8.8])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2F719DDDA4
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Feb 2009 11:16:54 +1100 (EST)
Date: Wed, 11 Feb 2009 00:16:36 +0000
From: Ben Dooks <ben-linux@fluff.org>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] i2c-mpc: do not allow interruptions when waiting for
	I2C   to complete
Message-ID: <20090211001636.GA19758@fluff.org.uk>
References: <1233928837-3401-1-git-send-email-timur@freescale.com>
	<ed82fe3e0902100659p2eec9de6j61f9ffb504d60a89@mail.gmail.com>
	<20090210165554.0da8bf7c@hyperion.delvare>
	<4991A4F2.8030506@freescale.com>
	<20090210171000.1f45cc2d@hyperion.delvare>
	<4991A970.70508@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4991A970.70508@freescale.com>
Cc: Jean Delvare <khali@linux-fr.org>, linuxppc-dev@ozlabs.org,
	Kumar Gala <kumar.gala@freescale.com>, linux-i2c@vger.kernel.org,
	Ben Dooks <ben-linux@fluff.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Feb 10, 2009 at 10:21:04AM -0600, Timur Tabi wrote:
> Jean Delvare wrote:
> 
> > To the best of my knowledge i2c-mpc falls into the "embedded platforms"
> > category and is thus under Ben's responsibility.
> 
> I don't see his Signed-off-by on any patch to i2c-mpc.c for the past
> three years (at least).  I do see yours, however.  You have directly
> applied similar patches in the recent past, so of course I will assume
> that you would apply this one.

My appointment as an embedded maintainer is relatively recent.

I do try and review patches, and sometimes these patches get sent
to another maintainer.

-- 
Ben (ben@fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
