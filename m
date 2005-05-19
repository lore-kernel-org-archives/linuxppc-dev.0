Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 76163679EF
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 20 May 2005 06:13:31 +1000 (EST)
Date: Thu, 19 May 2005 13:13:29 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Sanjay Bajaj <sbajaj@tsi-telsys.com>
Message-ID: <20050519201329.GB27236@gate.ebshome.net>
References: <0007F077BB3476449151699150E8FEA21A7B9E@exchange.tsi-telsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <0007F077BB3476449151699150E8FEA21A7B9E@exchange.tsi-telsys.com>
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

On Thu, May 19, 2005 at 03:45:50PM -0400, Sanjay Bajaj wrote:
> Eugene,
> 
> Yes, TAH0 in SDR0_MFR register is enabled.
> 
> EMAC is able to reset correctly, but TAH isn't at the same location 
> [in emac_probe()]. PHY is connected to EMAC and TAH is behind EMAC. 
> I do not understand how the RX clock from PHY will reach TAH? Any suggestions ?

E.g. TAH RX path is clocked from the same source as EMAC, I think 
it's quite obvious, but I digress.

What are you doing? Having problems with EMAC driver? What kernel 
version? What board?

You can try my new NAPI EMAC driver (http://kernel.ebshome.net/).

-- 
Eugene
