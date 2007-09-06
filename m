Return-Path: <Sylvain.Joyeau@thomson.net>
Received: from dmzraw4.extranet.thmulti.com (dmzraw4.extranet.thmulti.com
	[141.11.234.72]) by ozlabs.org (Postfix) with ESMTP id 001B5DDF13
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  6 Sep 2007 18:44:38 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Gianfar - MPC8541 - tx buffer overrun errors
Date: Thu, 6 Sep 2007 10:43:09 +0200
Message-ID: <B00307ADBC68954AA8D6FB3AC8FD66F3014E1FC4@rennsmail05.eu.thmulti.com>
From: "Joyeau Sylvain" <Sylvain.Joyeau@thomson.net>
To: "Shriram Janardhan" <shriramjanardhan@yahoo.com>,
	<linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Shriram,

Try to increase the DEFAULT_TX_RING_SIZE parameter in gianfar.h.
Enabling NAPI mechanism should have no effect on transmission side.

Cheers
--
sj


________________________________

	From:
linuxppc-embedded-bounces+sylvain.joyeau=3Dthomson.net@ozlabs.org
[mailto:linuxppc-embedded-bounces+sylvain.joyeau=3Dthomson.net@ozlabs.org=
]
On Behalf Of Shriram Janardhan
	Sent: jeudi 6 septembre 2007 03:49
	To: linuxppc-embedded@ozlabs.org
	Subject: Gianfar - MPC8541 - tx buffer overrun errors
=09
=09
	All,
	=20
	I am running 2.6.11 version of the kernel on MPC8541.  Have one
of the TSECs configured at 100Mbps/Full Duplex.  The TSEC MAC is
connected to a Marvell Ethernet switch MAC without any PHY in between.
MAC level flow control is enabled but no pause frames sent or received.
	=20
	I see a high number of transmit buffer overrun errors
(tx_fifo_empty errors in the gianfar driver).  I don't have NAPI
enabled.  In addition to other things, I was thinking of enabling NAPI
and see if it helps - is there any downside to it??  Are there any other
parameters that I could tweak to reduce/eliminate the overrun errors??
	=20
	Thanks,
	Shriram.
	=20

	________________________________

	Got a little couch potato?=20
	Check out fun summer activities for kids.
<http://us.rd.yahoo.com/evt=3D48248/*http://search.yahoo.com/search?fr=3D=
oni
_on_mail&p=3Dsummer+activities+for+kids&cs=3Dbz>=20
