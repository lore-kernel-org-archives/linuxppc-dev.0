Return-Path: <scottwood@freescale.com>
Date: Wed, 11 Jun 2008 11:53:55 -0500
From: Scott Wood <scottwood@freescale.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: Image generation for Efika is broken in 2.6.26
Message-ID: <20080611165355.GB2779@loki.buserror.net>
References: <9e4733910806100738rac8e415x99f6e96715ebee90@mail.gmail.com>
	<20080610165719.GA5139@loki.buserror.net>
	<484FD30B.3020105@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <484FD30B.3020105@pengutronix.de>
Cc: linuxppc-dev list <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jun 11, 2008 at 03:28:43PM +0200, Marc Kleine-Budde wrote:
> Scott Wood wrote:
> > Are you using binutils 2.17?  It has a bug that was triggered by the
> > p_paddr change.  Do you get a bunch of warnings from the strip command?
> 
> Same problem here with binutils-2.17. But no warnings from strip. Can
> you give me some pointers to the original bug report or the fix of the
> problem in the binutils svn. I've searched this mailinglist and the
> binutils bugzilla, but without success.

Not sure, I just know that I don't see the behavior on anything before or
after 2.17.  This is the closest I found, though it's post-2.18:

http://www.nabble.com/Zero-p_paddr-confuses-BFD-td17002340.html

-Scott
