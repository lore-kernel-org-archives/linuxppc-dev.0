Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: cbe-oss-dev@ozlabs.org
Subject: Re: [Cbe-oss-dev] [patch 04/11] powerpc/spufs: add atomic busy_spus
	counter to struct cbe_spu_info
Date: Mon, 7 Jul 2008 10:50:32 +0200
References: <20080704190535.316377278@arndb.de>
	<1215407941.8970.63.camel@pasglop>
	<20080707153012.5106e961.sfr@canb.auug.org.au>
In-Reply-To: <20080707153012.5106e961.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200807071050.32749.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, Stephen Rothwell <sfr@canb.auug.org.au>,
	Jeremy Kerr <jk@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 07 July 2008, Stephen Rothwell wrote:
> 
> > > From: Maxim Shchetynin <maxim@de.ibm.com>
> > > Signed-off-by: Christian Krafft <krafft@de.ibm.com>
> > 
> > This needs your S-O-B, Arnd, and should go via jk.

I noticed the missing S-O-B already after I had sent it, and corrected
it in the git.

Since this patch is a prerequisite for patch 5/11, I'd like to keep them
in order. Jeremy, can you add your Acked-by?

> And the From line should be the first so the Author is correctly
> attributed.

Right, this one again got missing in quilt-mail.

	Arnd <><
