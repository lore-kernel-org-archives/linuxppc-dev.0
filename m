Return-Path: <sven.luther@wanadoo.fr>
Date: Tue, 8 Mar 2005 20:28:05 +0100
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <20050308192805.GA13884@pegasos>
References: <422C495B.8090805@katalix.com>
	<20050307125808.6585A200008A@mwinf0308.wanadoo.fr>
	<20050307225401.GA31041@xyzzy> <20050308064945.GC27722@pegasos>
	<1110266832.13607.267.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1110266832.13607.267.camel@gaston>
From: Sven Luther <sven.luther@wanadoo.fr>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Dale Farnsworth <dale@farnsworth.org>,
	linuxppc-embedded@ozlabs.org, Nicolas DET <det.nicolas@free.fr>
Subject: [PATCH] final mv643xx_eth pegasos patch set ...
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello,

Ok, thanks for your help, here is the final (hopefully) and cleaned up version
of my patches :

  1) mv643xx-eth-pegasos.diff
  This is the arch/ppc/platform diff, benh, could you look it over, and merge
  it in ? It is not really usefull without the mv643xx_eth.c changes, but dale
  is going to move those in together with his patches.

  2) linux-2.5-mv643xx-enet-pegasos.diff
  This is just two small hunks against dale's linux-2.5-mv643xx-enet tree,
  which include the SA_INTERRUPT -> SA_IRQ and the Kconfig change. Dale said
  he would merge them with his stuff, hopefully for 2.6.12.

  3) mv643xx-eth.diff
  This is the linux-2.5-mv643xx-enet diff against 2.6.11, together with the
  linux-2.5-mv643xx-enet-pegasos.diff changes, for those who want to build
  against 2.6.11.

So to build against the linux-2.5-mv643xx-enet tree, you need 1) and 2) and to
build against 2.6.11 you need 1) and 3).

I am currently running the patches included in these changes, and will include
them in the debian 2.6.11 kernels unless i hear otherwise. 

Friendly,

Sven Luther
