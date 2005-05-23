Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 3E443679E6
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 24 May 2005 06:04:09 +1000 (EST)
Date: Mon, 23 May 2005 13:04:06 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Sanjay Bajaj <sbajaj@tsi-telsys.com>
Message-ID: <20050523200406.GA10295@gate.ebshome.net>
References: <0007F077BB3476449151699150E8FEA21A7BA0@exchange.tsi-telsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <0007F077BB3476449151699150E8FEA21A7BA0@exchange.tsi-telsys.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: tah reset?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, May 23, 2005 at 03:17:26PM -0400, Sanjay Bajaj wrote:
> I did find the source of the reset tah issue. The physical address 
> of TAH 0 and TAH 1 was ending in B00h and D00h respectively. But in 
> the UM, it ends in B50 and D50. the file affected is ibm440gx.c in 
> arch/ppc/platforms.

Linux 2.6 has correct values for TAH base address, 2.4 doesn't have 
any support for TAH at all.

Where did you get this incorrect code?

You see, you should have used supported sources (2.6) or the one I 
recommended to you (my 2.4 backport) but you have ignored this  
suggestion and wasted your time and time of people on this mail list.

Please, next time if you use some stuff which isn't in kernel.org's 
tree, direct you questions to the person who made those patches, 
because we cannot help you as we don't have the source code you are 
using.

-- 
Eugene
