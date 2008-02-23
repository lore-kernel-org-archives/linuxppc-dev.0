Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4735BDDE40
	for <linuxppc-dev@ozlabs.org>; Sun, 24 Feb 2008 07:47:25 +1100 (EST)
Subject: Re: [PATCH 5/5] [POWERPC] Add 460EX PCIe support to 4xx pci driver
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <18367.34338.962846.402664@cargo.ozlabs.ibm.com>
References: <1203602482-11415-1-git-send-email-sr@denx.de>
	<18367.34338.962846.402664@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Sun, 24 Feb 2008 07:46:48 +1100
Message-Id: <1203799608.6976.44.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Stefan Roese <sr@denx.de>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sat, 2008-02-23 at 13:34 +1100, Paul Mackerras wrote:
> Stefan Roese writes:
> 
> > Tested on AMCC Canyonlands eval board.
> > 
> > Signed-off-by: Stefan Roese <sr@denx.de>
> 
> With 173 lines of code added, you could spend a paragraph in the patch
> description telling us why the patch is doing what it's doing the way
> it's doing it.  Perhaps even tell us why it takes 173 new lines of
> code to do something that sounds pretty simple - tell us what the
> complexities you encountered were.

Actually, the patch just adds a backend to my little framework for
dealing with 4xx PCIe, which basically is a boring piece of code
filling registers with values mostly from the spec... nothing really
fancy there.

Cheers,
Ben.
