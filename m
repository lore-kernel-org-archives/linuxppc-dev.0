Return-Path: <ronb@lcsaudio.com>
Received: from pd4mo1so.prod.shaw.ca (shawidc-mo1.cg.shawcable.net
	[24.71.223.10]) by ozlabs.org (Postfix) with ESMTP id BF85667A71
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  1 Mar 2005 12:24:20 +1100 (EST)
Received: from pd3mr3so.prod.shaw.ca
	(pd3mr3so-qfe3.prod.shaw.ca [10.0.141.179]) by l-daemon
	(Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
	with ESMTP id <0ICN0032LFWJ5V70@l-daemon> for
	linuxppc-embedded@ozlabs.org; Mon, 28 Feb 2005 18:24:19 -0700 (MST)
Received: from pn2ml6so.prod.shaw.ca ([10.0.121.150])
	by pd3mr3so.prod.shaw.ca (Sun ONE Messaging Server 6.0 HotFix 1.01
	(built Mar
	15 2004)) with ESMTP id <0ICN00APVFWJJU40@pd3mr3so.prod.shaw.ca> for
	linuxppc-embedded@ozlabs.org; Mon, 28 Feb 2005 18:24:19 -0700 (MST)
Received: from ronsp4 ([24.70.124.240])
	by l-daemon (iPlanet Messaging Server 5.2 HotFix 1.18 (built Jul 28
	2003))
	with SMTP id <0ICN00I5SFWIGE@l-daemon> for linuxppc-embedded@ozlabs.org;
	Mon, 28 Feb 2005 18:24:19 -0700 (MST)
Date: Mon, 28 Feb 2005 17:23:55 -0800
From: Ron Bianco <ronb@lcsaudio.com>
To: Linuxppc-Embedded <linuxppc-embedded@ozlabs.org>
Message-id: <NCBBJPCHJLKAEAHINDCEGEJFFMAA.ronb@lcsaudio.com>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Subject: linuxppc tree with mv64xxx included?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


I'm trying to locate the correct bitkeeper or other URL to get access to a
linux 2.5 or 2.6 tree that includes the support for the marvell mv64xxx
series chips.
I've examined the emails in this list regarding related patches for clues,
but am still confused.

Tried bk://ppc.bkbits.net/linuxppc-2.5, but there is no marvell code.

We downloaded a 2.4.23 kernel tree directly from the marvell website, but it
is lacking some things like i2c for marvell, that have been discussed here.
Was further work, existing in some other tree, based on this?

FYI, we're bringing up a custom MPC7447A based board with the mv64462.

Thanks in advance,

Ron Bianco
