Return-Path: <sven.luther@wanadoo.fr>
Received: from smtp10.wanadoo.fr (smtp10.wanadoo.fr [193.252.22.21])
	by ozlabs.org (Postfix) with ESMTP id B85AE6855F
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 28 Oct 2005 04:50:56 +1000 (EST)
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf1004.wanadoo.fr (SMTP Server) with ESMTP id 90AA12400109
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 27 Oct 2005 20:50:52 +0200 (CEST)
Date: Thu, 27 Oct 2005 20:49:21 +0200
To: "Mark A. Greer" <mgreer@mvista.com>
Message-ID: <20051027184921.GA11742@localhost.localdomain>
References: <ec55b17e0510270617k368b4555gf3f37e07cee3b4e6@mail.gmail.com>
	<20051027181751.GD9628@mag.az.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20051027181751.GD9628@mag.az.mvista.com>
From: Sven Luther <sven.luther@wanadoo.fr>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Board based on MPC7447 and MV64462
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Oct 27, 2005 at 11:17:51AM -0700, Mark A. Greer wrote:
> On Thu, Oct 27, 2005 at 06:47:29PM +0530, Ashish Bijlani wrote:
> > Hi,
> > 
> > I've added platform support for a board based on MPC7447A and MV64462
> > Marvell Discovery III system controller. I modified code for Katana to make
> > it work for this board. The ethernet and serial are working fine but I don't
> > see anything in "lspci" output.
> 
> Do you have any pci devices?  If not, then that's to be expected.
> If you do, then you have something messed up in your code and they
> aren't being found.

They should at least shgow the northbridge pci ids, no ? 

Friendly,

Sven Luther
