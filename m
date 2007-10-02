Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 39702DDEDB
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Oct 2007 16:22:55 +1000 (EST)
Subject: Re: [PATCH 6/7] Add dcr_map_reg() helper
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: michael@ellerman.id.au
In-Reply-To: <1191304300.6593.2.camel@concordia>
References: <449a181e8169af98984bb2d61a759c23e55d19b4.1190009070.git.michael@ellerman.id.au>
	<60649f36e785af905b8cb1fd12847d7630e7371a.1190009070.git.michael@ellerman.id.au>
	<1191302382.6310.80.camel@pasglop> <1191304300.6593.2.camel@concordia>
Content-Type: text/plain
Date: Tue, 02 Oct 2007 16:22:45 +1000
Message-Id: <1191306165.6310.103.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Tue, 2007-10-02 at 15:51 +1000, Michael Ellerman wrote:
> On Tue, 2007-10-02 at 15:19 +1000, Benjamin Herrenschmidt wrote:
> > On Mon, 2007-09-17 at 16:05 +1000, Michael Ellerman wrote:
> > > Add a helper routine to map dcr's based on the "dcr-reg" property of
> > > a device node.
> > > 
> > > Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
> > 
> > Wouldn't it be more consistent to call it of_map_dcr ? Or maybe find an
> > even better name, but dcr_map_reg really sucks :-)
> 
> That would give us dcr_map(), dcr_unmap() and of_map_dcr() - which
> doesn't strike me as more consistent.
> 
> I don't particularly like dcr_map_reg(), but I think it's at least
> obvious that it's a variant of dcr_map() and that it has something to do
> with a "reg" .. maybe even a "dcr-reg" :)

dcr_map_node maybe ? dcr_map_device ? dcr_map_property ? hrm...
allright, keep it that way if you want but heh, at least see if you can
come up with something better before it gets merged :-)

Ben
