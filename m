Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id E6E16DDE0C
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Sep 2007 13:36:55 +1000 (EST)
Date: Tue, 11 Sep 2007 22:37:52 -0500
From: Olof Johansson <olof@lixom.net>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC] 85xx: Add basic Uniprocessor MPC8572 DS port
Message-ID: <20070912033752.GA21155@lixom.net>
References: <230A7A2A-3184-4BC2-B8AC-C94090B532B0@kernel.crashing.org>
	<20070911155558.GA10743@lixom.net>
	<11B85E70-D643-4013-A9B3-59CD76F9D7AB@kernel.crashing.org>
	<20070911171521.GB10743@lixom.net> <46E6CE9A.8080402@freescale.com>
	<20070911173308.GA11951@lixom.net> <46E6D4D4.2050600@freescale.com>
	<C1272D92-42A0-43E4-9AE0-12161178AAA2@kernel.crashing.org>
	<20070912030005.GA20218@localhost.localdomain>
	<0F762D4F-C84B-4979-92D4-42C5D40AE455@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <0F762D4F-C84B-4979-92D4-42C5D40AE455@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Sep 11, 2007 at 10:35:01PM -0500, Kumar Gala wrote:
> > In the meantime, couldn't the code still be merged, using an explicit
> > test of the root node's 'compatible' or 'model' properties to decide
> > on the right primary bus.
> 
> I will be, I'm not going to wait on having some device tree spec for  
> this.  The board code can handle it until we come to some agreement  
> on how to do this.  I'm in agreement with Scott in that code should  
> be added to scan or allow explicit determination.  Adding a 'prop' to  
> the device tree just for linux seems a bit silly.

Sounds good to me as well.


-Olof
