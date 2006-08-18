Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7617E67B32
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Aug 2006 12:00:05 +1000 (EST)
Subject: Re: [PATCH] Directly reference i8259@4d0 nodes in mpc8641_hpcn.dts.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Mark A. Greer" <mgreer@mvista.com>
In-Reply-To: <20060818004301.GA8734@mag.az.mvista.com>
References: <1155835482.10054.140.camel@cashmere.sps.mot.com>
	<1155840700.27466.64.camel@basalt.austin.ibm.com>
	<1155849609.10054.175.camel@cashmere.sps.mot.com>
	<1155859761.5803.6.camel@localhost.localdomain>
	<20060818004301.GA8734@mag.az.mvista.com>
Content-Type: text/plain
Date: Fri, 18 Aug 2006 11:59:48 +1000
Message-Id: <1155866388.5803.10.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2006-08-17 at 17:43 -0700, Mark A. Greer wrote:
> On Fri, Aug 18, 2006 at 10:09:21AM +1000, Benjamin Herrenschmidt wrote:
> > On Thu, 2006-08-17 at 16:20 -0500, Jon Loeliger wrote:
> > > Rather than using some hand-coded linux,phandle
> > > node references, use DTC's direct node refs ability
> > > and let it manage the phandle names instead.
> > 
> > Not 100% sure here but can't we use a label and do &label rather than
> > having to copy the full path every time ? Would make things easier :) If
> > not, that's probably something to add to dtc...
> 
> Isn't linux,phandle basically the label that you speak of, though?
> IOW, you may be saying, "No, keep using the linux,phandle".

No, more something like

pic:
  <pic_node>

and later

&pic

> Just trying to clarify things although I'm not sure that I really am...  :)
> 
> Mark
