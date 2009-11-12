Return-Path: <roman.fietze@telemotive.de>
Received: from coyote.quickmin.net (coyote.quickmin.net [217.14.112.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.quickmin.de", Issuer "smtp.quickmin.de" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id EEB46B6F2B
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 12 Nov 2009 17:34:04 +1100 (EST)
Received: from rfietze.mit.telemotive.de (rfietze.mit.telemotive.de
	[192.168.5.33])
	by alderan.mit.telemotive.de (Postfix) with ESMTP id A3B64BC99A
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 12 Nov 2009 07:33:58 +0100 (CET)
From: Roman Fietze <roman.fietze@telemotive.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: Micrel PHY KSZ8001 on MPC5200B FEC
References: <mailman.1198.1256674402.12812.linuxppc-dev@lists.ozlabs.org>
	<200910281420.n9SEKI2R005094@nti1.com>
In-Reply-To: <200910281420.n9SEKI2R005094@nti1.com>
MIME-Version: 1.0
Message-ID: <200911120733.58112.roman.fietze@telemotive.de>
Date: Thu, 12 Nov 2009 07:33:58 +0100
Content-Type: Text/Plain;
  charset="iso-8859-1"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Suvidh,

On Wednesday 28 October 2009 16:19:04 suvidh kankariya wrote:

> I am sorry for the misguided statement.

No problem, help is always welcome.

> I indeed had patched it.

Allthough Grant's mail got stuck in our beloved Notes spam filter, we
found out how to use that KSZ8001 on our board.

As Grant mentioned as well, the key was and is a correct DTS. (At
least) one statement was missing:

  interrupt-parent =3D <&mpc5200_pic>;

This statement seemed to move all the way up from the devices to the
root of the tree, and somehow we missed that move.

Thanks again to all who answered.


Roman

=2D-=20
Roman Fietze                Telemotive AG B=FCro M=FChlhausen
Breitwiesen                              73347 M=FChlhausen
Tel.: +49(0)7335/18493-45        http://www.telemotive.de
