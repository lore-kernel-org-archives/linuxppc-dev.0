Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id E58ED679F1
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 20 May 2005 04:23:15 +1000 (EST)
Date: Thu, 19 May 2005 11:23:11 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Sanjay Bajaj <sbajaj@tsi-telsys.com>
Message-ID: <20050519182311.GA27236@gate.ebshome.net>
References: <0007F077BB3476449151699150E8FEA21A7B9D@exchange.tsi-telsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <0007F077BB3476449151699150E8FEA21A7B9D@exchange.tsi-telsys.com>
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

On Thu, May 19, 2005 at 02:14:20PM -0400, Sanjay Bajaj wrote:
> While trying to reset the TAH on emac2 of PPC440GX, the Soft Reset 
> (SR) bit never resets itself to 0. Does anybody know the reason for 
> it?

Did you enable TAH0 in SDR0_MFR register?

Also, I don't remember for sure, but TAH may have the same problem as 
EMAC, namely, it won't go out of reset if there is no RX clock from 
PHY.

-- 
Eugene
