Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 547C067A9D
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 23 Feb 2005 15:22:40 +1100 (EST)
Date: Tue, 22 Feb 2005 20:22:34 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: Shawn Jin <shawnxjin@gmail.com>
Message-ID: <20050223042234.GA31255@gate.ebshome.net>
References: <c3d0340b050222190712ee7dff@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <c3d0340b050222190712ee7dff@mail.gmail.com>
Cc: ppcembed <linuxppc-embedded@ozlabs.org>
Subject: Re: Ethernet doesn't work in linux for PPC440GP?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, Feb 22, 2005 at 07:07:44PM -0800, Shawn Jin wrote:
> zmii0: input 0 in SMII mode
> eth0: IBM emac, MAC 00:04:ac:e3:1b:bb
> eth0: Found Generic MII PHY (0x08)
> zmii0: input 1 in RMII mode
> eth1: IBM emac, MAC FF:FF:FF:FF:FF:FF
> eth1: Found Generic MII PHY (0x09)

I already told you that this is wrong, why are you asking again? 
Please, if you asking questions, spend some time reading answers 
given to you, before asking again.

ZMII bridge cannot have inputs in different modes (SMII and RMII).

Ebony uses RMII, so SMII is obviously wrong. Most probably your 
firmware doesn't set correct mode and autodetection in the EMAC driver 
fails.

--
Eugene.
