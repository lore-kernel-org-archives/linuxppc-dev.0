Return-Path: <sven.luther@wanadoo.fr>
Received: from mwinf0305.wanadoo.fr (smtp3.wanadoo.fr [193.252.22.28])
	by ozlabs.org (Postfix) with ESMTP id 532592BEA0
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Dec 2004 17:41:12 +1100 (EST)
Received: from smtp3.wanadoo.fr (mwinf0306 [172.22.134.34])
	by mwinf0305.wanadoo.fr (SMTP Server) with ESMTP id 91CBEC00C93
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Dec 2004 07:20:38 +0100 (CET)
Date: Thu, 23 Dec 2004 07:25:15 +0100
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <20041223062515.GB4546@pegasos>
References: <1103739194.5316.1.camel@gaston> <1103740513.29974.0.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1103740513.29974.0.camel@gaston>
From: Sven Luther <sven.luther@wanadoo.fr>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	"debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>
Subject: Re: [PATCH] Fix Alsa issues including Oopses with OSS emulation
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Dec 22, 2004 at 07:35:13PM +0100, Benjamin Herrenschmidt wrote:
> On Wed, 2004-12-22 at 19:13 +0100, Benjamin Herrenschmidt wrote:
> > This patch (which will be send upstream separately by the Alsa folks) fixes
> > an signed vs. unsigned char problem in Alsa which was the cause of the Oops
> > people were experiencing on ppc with OSS emulation and possibly other issues.
> 
> Ok, actually, the one that will be commited upstream is a bit different,
> here it is:

Ben, i suppose this one is for inclusion in the debian kernel too, do you
think you could send such patches as bug reports against kernel-source-2.6.8
package, or to debian-kernel also ? 

Friendly,

Sven Luther
