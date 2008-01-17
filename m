Return-Path: <scottwood@freescale.com>
Date: Thu, 17 Jan 2008 12:48:10 -0600
From: Scott Wood <scottwood@freescale.com>
To: Jochen Friedrich <jochen@scram.de>
Subject: Re: [PATCH/RFC] [POWERPC] CPM1: implement GPIO LIB API
Message-ID: <20080117184810.GA3957@loki.buserror.net>
References: <478F4514.7030906@scram.de>
	<fa686aa40801170547q8c758dxef5aa301396f7f38@mail.gmail.com>
	<478F6972.9080308@scram.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <478F6972.9080308@scram.de>
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd@arndb.de>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jan 17, 2008 at 03:42:58PM +0100, Jochen Friedrich wrote:
> Hi Grant,
> 
> >>  arch/powerpc/platforms/8xx/Kconfig |    2 +
> >>  arch/powerpc/sysdev/commproc.c     |  162 +++++++++++++++++++++++++++++++++++-
> > 
> > Is this 8xx only?  Can it live in arch/powerpc/platforms/8xx?
> 
> According to the freescale docs, the GPIO ports are part of the CPM1. So I've put the
> support into commproc.c (which maybe should be renamed to cpm1_common.c to match cpm2_common.c).
> 
> AFAIK, CPM1 is specific to 8xx.

If we're going to rename, I'd change commproc.c to cpm1.c, and cpm2_common.c
to cpm2.c.

-Scott
