Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id CFA6F2BC0F
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 21 Oct 2004 02:11:51 +1000 (EST)
Date: Wed, 20 Oct 2004 09:11:48 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: "Lawrence E. Bakst" <ml@iridescent.org>
Message-ID: <20041020161148.GA17445@gate.ebshome.net>
References: <p06110435bd9bb541f839@iridescent.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <p06110435bd9bb541f839@iridescent.org>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Is linux-2.5-ocp the current 2.6 4xx code base
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, Oct 20, 2004 at 01:02:21AM -0700, Lawrence E. Bakst wrote:
> At 4:23 PM -0700 5/14/04, Matt Porter wrote:
> >There is a tree, bk://source.mvista.com/linux-2.5-ocp, that has most
> >4xx boards working, but it's 2.6.5.  The core 4xx support is moving into
> >current 2.6, but it will be a little bit longer until important drivers
> >like EMAC and IIC are merged into the stock kernel.
> 
> Is the linux-2.5-ocp tree still the right place to get 2.6 4xx code or has that code been moved upstream or someplace else?

Linux-2.5-ocp is obsolete.

> To be more specific which tree to a "bk clone" to get the latest stuff for 4xx.

Use kernel.org's BK tree: bk://linux.bkbits.net/linux-2.5

--
Eugene
