Return-Path: <CFRIESEN@nortel.com>
Received: from zrtps0kp.nortel.com (zrtps0kp.nortel.com [47.140.192.56])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "", Issuer "NORTEL" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id DA219B7CFB
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Feb 2010 03:15:44 +1100 (EST)
Message-ID: <4B7EB5C6.8080502@nortel.com>
Date: Fri, 19 Feb 2010 10:01:10 -0600
From: "Chris Friesen" <cfriesen@nortel.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, paulus@samba.org,
	linuxppc-dev@ozlabs.org
Subject: anyone used the Marvell mv64560?
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Is anyone familiar with the mv64560?  I'm curious how much difference
there might be from the older mv64360 as far as setting up the PCI bus,
cpu bus, i2c, memory, etc.

I don't see any mention of this chip in current linux sources, but
there's some mention of people trying it and it's referenced in one of
the text files in Documentation...is it supported?  Are there any caveats?

We'll be going through proper channels eventually but I thought I'd
check here just in case.

Any information appreciated.

Thanks,

Chris
