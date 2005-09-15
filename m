Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17193.22140.962651.122114@cargo.ozlabs.ibm.com>
Date: Thu, 15 Sep 2005 21:09:48 +1000
From: Paul Mackerras <paulus@samba.org>
To: Jon Loeliger <jdl@freescale.com>
In-Reply-To: <1126705588.14036.10.camel@cashmere.sps.mot.com>
References: <1126644202.11056.59.camel@cashmere.sps.mot.com>
	<200509140435.21916.arnd@arndb.de>
	<1126705588.14036.10.camel@cashmere.sps.mot.com>
Cc: linuxppc64-dev <linuxppc64-dev@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Subject: Re: PATCH powerpc: Merge asm-ppc*/sections.h
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jon Loeliger writes:

> In the Grand Scheme of Things, removing things and making them
> simpler seems a lofty goal. :-)   Anyone know of any pitfalls that
> await me if I try to remove these sections, a la pmac and friends?

You'll probably get most objection from the PReP users, for whom
getting back a few hundred kB is a big deal.  (Maybe we should just
buy both of them a G5 or something. 8-)

> And I assume that the obvious mappings can take place (ie, that
> "pmac.text" can just be placed in regular .text, etc), right?

Yes.

Paul.
