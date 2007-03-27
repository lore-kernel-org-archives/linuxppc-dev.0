Return-Path: <AZeffertt@cambridgebroadband.com>
Received: from cambridgebroadband.com (mailhost.cambridgebroadband.com
	[217.204.121.83])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 05C92DDEFD
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 27 Mar 2007 19:40:29 +1000 (EST)
Message-ID: <4608D8E0.2040101@cambridgebroadband.com>
Date: Tue, 27 Mar 2007 09:42:08 +0100
From: "Alex Zeffertt" <ajz@cambridgebroadband.com>
MIME-Version: 1.0
To: "DI BACCO ANTONIO - technolabs" <Antonio.DiBacco@technolabs.it>
Subject: Re: Accessng phy registers
References: <F1F6EC0C8B75034F9E3A79FC85122E8E264947@aquib01a>
In-Reply-To: <F1F6EC0C8B75034F9E3A79FC85122E8E264947@aquib01a>
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1"
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

DI BACCO ANTONIO - technolabs wrote:
 >
 > I saw that both in phy,c and mii.c (linux 2.6.19) there is support to
 > handle ioctls to read PHY registers. Why? And what should be used =
from a
 > user application? I have both CONFIG_MII and CONFIG_PHYLIB set to y.

Try "mii-tool -vv".  This uses the ioctls to extract the PHY registers.

If your ethernet driver doesn't support mii-tool it may support =
"ethtool"
instead.  Some drivers support both.

Alex

-------------------------------------------------------------------------=
-----=0A=
=0A=
Cambridge Broadband appoints telecoms industry veteran John Cronin as =
chairman <<http://www.cambridgebroadband.com/mi20feb07.htm>=0A=
=0A=
Maxis to upgrade its backhaul network using Cambridge Broadband; =
Alcatel-Lucent selected to manage entire upgrade project =
<http://www.cambridgebroadband.com/mi12feb07.htm>=0A=


-------------------------------------------------------------------------=
-----
Cambridge Broadband Networks Limited
Registered in England and Wales under company number: 03879840
Registered office: Selwyn House, Cambridge Business Park, Cowley Road, =
Cambridge CB4 0WZ, UK
=20
This email and any attachments are private and confidential. If you =
believe you have received this email in error please inform the sender =
and delete it from your mailbox or any other storage mechanism. =
Cambridge Broadband Networks Limited cannot accept liability for any =
statements made which are clearly the individual sender's own and not =
expressly made on behalf of Cambridge Broadband Networks Limited.
