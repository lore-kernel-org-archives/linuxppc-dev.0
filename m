Return-Path: <mgreer@mvista.com>
Received: from gateway-1237.mvista.com (gateway-1237.mvista.com
	[63.81.120.158]) by ozlabs.org (Postfix) with ESMTP id CD2D5679E7
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Aug 2006 10:38:56 +1000 (EST)
Date: Thu, 17 Aug 2006 17:43:01 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] Directly reference i8259@4d0 nodes in mpc8641_hpcn.dts.
Message-ID: <20060818004301.GA8734@mag.az.mvista.com>
References: <1155835482.10054.140.camel@cashmere.sps.mot.com>
	<1155840700.27466.64.camel@basalt.austin.ibm.com>
	<1155849609.10054.175.camel@cashmere.sps.mot.com>
	<1155859761.5803.6.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1155859761.5803.6.camel@localhost.localdomain>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Aug 18, 2006 at 10:09:21AM +1000, Benjamin Herrenschmidt wrote:
> On Thu, 2006-08-17 at 16:20 -0500, Jon Loeliger wrote:
> > Rather than using some hand-coded linux,phandle
> > node references, use DTC's direct node refs ability
> > and let it manage the phandle names instead.
> 
> Not 100% sure here but can't we use a label and do &label rather than
> having to copy the full path every time ? Would make things easier :) If
> not, that's probably something to add to dtc...

Isn't linux,phandle basically the label that you speak of, though?
IOW, you may be saying, "No, keep using the linux,phandle".

Just trying to clarify things although I'm not sure that I really am...  :)

Mark
