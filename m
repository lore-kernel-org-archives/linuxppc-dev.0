Return-Path: <b07421@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id DEE3BDDE30
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Mar 2007 02:36:48 +1100 (EST)
Date: Tue, 13 Mar 2007 09:36:43 -0600
From: Scott Wood <scottwood@freescale.com>
To: paulus@samba.org, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 08/19] bootwrapper: Rename p and pp to anchor and
	anchorptr.
Message-ID: <20070313153643.GC3476@ld0162-tx32.am.freescale.net>
References: <20070312204150.GH28545@ld0162-tx32.am.freescale.net>
	<20070313021955.GK29506@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070313021955.GK29506@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Mar 13, 2007 at 01:19:55PM +1100, David Gibson wrote:
> On Mon, Mar 12, 2007 at 02:41:50PM -0600, Scott Wood wrote:
> > This makes the meaning of "p" clearer, and increases the visual
> > difference between the two to avoid bugs such as the one fixed in
> > "Modify *pp, not *p, in ft_shuffle()".
> 
> Hrm.  This does increase the visual difference, but honestly the
> meaning of "anchor" is not notably more obvious to me than "p".

The idea was that it's where the caller holds on to when the data gets
moved around.  I agree that it's not a great name, but I couldn't think
of anything better (and previously, someone requested that I change the
name from p).  Any suggestions?

-Scott
