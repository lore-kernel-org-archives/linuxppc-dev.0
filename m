Return-Path: <sven.luther@wanadoo.fr>
Received: from smtp12.wanadoo.fr (smtp12.wanadoo.fr [193.252.22.20])
	by ozlabs.org (Postfix) with ESMTP id D5E6167A7C
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Mar 2005 18:01:52 +1100 (EST)
Date: Tue, 8 Mar 2005 07:49:45 +0100
To: Dale Farnsworth <dale@farnsworth.org>
Message-ID: <20050308064945.GC27722@pegasos>
References: <422C495B.8090805@katalix.com>
	<20050307125808.6585A200008A@mwinf0308.wanadoo.fr>
	<20050307225401.GA31041@xyzzy>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20050307225401.GA31041@xyzzy>
From: Sven Luther <sven.luther@wanadoo.fr>
Cc: Nicolas DET <det.nicolas@free.fr>, linuxppc-dev@ozlabs.org
Subject: Re: mv643xx_eth SA_SHIRQ support patch
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Mar 07, 2005 at 03:54:01PM -0700, Dale Farnsworth wrote:
> On Mon, Mar 07, 2005 at 12:57:39PM +0000, Nicolas DET wrote:
> > Hello James,
> > > - why do you need to use SA_SHIRQ in the ethernet driver?
> > 
> > Because the IRQ we use for ethernet is shared with others devices.
> 
> I've included an untested patch below that adds support for passing
> IRQ flags via platform device.

Notice that benh is telling me that you should use SA_SHIRQ always and that
SA_INTERRUPT should go away, and that you should contact him online if you
have trouble with that.

> For the pegasos 2, you'll need the second patch which applies after
> the one I previously sent for chrp_setup.c.

Ok, will test this anyway, and tell you how it works.

> Sven + Nicolas, please let me know if this compiles/works for you.

Yep.

Friendly,

Sven Luther
