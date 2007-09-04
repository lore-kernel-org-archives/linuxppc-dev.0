Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id 15037DDDFF
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  5 Sep 2007 00:06:03 +1000 (EST)
Subject: RE: Ethernet weirdness on 82xx
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Tue, 4 Sep 2007 09:06:07 -0500
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B0353A81A@ismail.innsys.innovsys.com>
In-Reply-To: <20070902110957.M44221@visp.net.lb>
References: <DCEAAC0833DD314AB0B58112AD99B93B0353A6AB@ismail.innsys.innovsys.com>
	<20070902110957.M44221@visp.net.lb>
From: "Rune Torgersen" <runet@innovsys.com>
To: "Denys" <denys@visp.net.lb>, <linuxppc-embedded@ozlabs.org>,
	<netdev@vger.kernel.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Denys [mailto:denys@visp.net.lb]=20
> Sent: Sunday, September 02, 2007 6:12 AM
> To: Rune Torgersen; linuxppc-embedded@ozlabs.org;=20
> netdev@vger.kernel.org
> Subject: Re: Ethernet weirdness on 82xx
>=20
> Thats normal.
> Check arp_filter sysctl :
> arp_filter - BOOLEAN

Thank you, that was it.

Did the following, and now I don't get the double resond anymore

#only respond to arps on the correct port
echo 1 > /proc/sys/net/ipv4/conf/all/arp_announce
echo 2 > /proc/sys/net/ipv4/conf/all/arp_ignore
