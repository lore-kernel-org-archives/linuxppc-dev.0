Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 21496DDDF6
	for <linuxppc-dev@ozlabs.org>; Sun, 16 Sep 2007 01:09:14 +1000 (EST)
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: [patch 3/4] 4xx: Convert Walnut flash mappings to new binding
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Sat, 15 Sep 2007 09:26:19 CDT."
	<1189866379.17593.2.camel@localhost.localdomain>
Date: Sat, 15 Sep 2007 17:09:01 +0200
Sender: wd@denx.de
Message-Id: <20070915150901.AC712247CE@gemini.denx.de>
Cc: linuxppc-dev@ozlabs.org, Stefan Roese <sr@denx.de>,
	david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In message <1189866379.17593.2.camel@localhost.localdomain> Josh Boyer wrote:
> On Sat, 2007-09-15 at 05:23 +0200, Stefan Roese wrote:
...
> > There are not only Bamboo board running PIBS, but running U-Boot too. How 
> > should we handle this different FLASH partitioning? Same goes for Ebony too 
> > btw.
> 
> That's a good question.  I'm working on making the NOR flash show up for
> Bamboo right now, and I had intended to just leave the partition
> subnodes missing.

Maybe we can have  U-Boot  add  the  partition  information  if  it's
missing in the device tree, and extend the mtdparts command in U-Boot
to add / adjust settings so they match what is defined in U-Boot.

Stefan, what do you think?

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Without facts, the decision cannot be made logically. You  must  rely
on your human intuition.
	-- Spock, "Assignment: Earth", stardate unknown
