Return-Path: <sven.luther@wanadoo.fr>
Received: from smtp5.wanadoo.fr (smtp5.wanadoo.fr [193.252.22.26])
	by ozlabs.org (Postfix) with ESMTP id A70A96857A
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Oct 2005 01:48:17 +1000 (EST)
Received: from smtp5.wanadoo.fr (mwinf0512 [172.22.136.36])
	by mwinf0510.wanadoo.fr (SMTP Server) with ESMTP id 618D73905
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Oct 2005 17:29:44 +0200 (CEST)
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf0512.wanadoo.fr (SMTP Server) with ESMTP id 12F641C00232
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Oct 2005 17:29:41 +0200 (CEST)
Date: Fri, 14 Oct 2005 17:18:30 +0200
From: Sven Luther <sl@bplan-gmbh.de>
To: Dale Farnsworth <dale@farnsworth.org>
Message-ID: <20051014151830.GA31442@localhost.localdomain>
References: <1129233624.4161.30.camel@localhost.localdomain>
	<20051014135641.15104.qmail@xyzzy.farnsworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20051014135641.15104.qmail@xyzzy.farnsworth.org>
Cc: linuxppc-dev@ozlabs.org, sl@bplan-gmbh.de
Subject: Re: [PATCH 2.6.14-rc3 1/1] chrp_pegasos_eth: Added Marvell
	Discovery II SRAM support
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Oct 14, 2005 at 01:56:41PM -0000, Dale Farnsworth wrote:
> > -	static struct pci_device_id pci_marvell_mv64360[] = {
> > +	static struct pci_device_id pci_marvell_mv64360[] =
> > +	{
> 
> > +	if (pci_dev_present(pci_marvell_mv64360))
> > +	{
> 
> Open brace should not be on a line by itself except in function definitions.

Oh, neat, i knew i should not use same-line-braces for function but didn't
know i should use them for non-functions :)

Friendly,

Sven Luther
