Return-Path: <tnt@blacksnow.net>
Received: from misato.blacksnow.net (212.68.194.10.brutele.be [212.68.194.10])
	by ozlabs.org (Postfix) with ESMTP id 285BD67A6E
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 28 Mar 2005 19:28:47 +1000 (EST)
Message-ID: <1240.81.240.238.58.1112000312.squirrel@webmail.blacksnow.net>
In-Reply-To: <4246B8E6.4060401@varma-el.com>
References: <0.20050327_004704.tnt@patchsend.246tNt.com>
	<4246B8E6.4060401@varma-el.com>
Date: Mon, 28 Mar 2005 10:58:32 +0200 (CEST)
From: tnt@blacksnow.net
To: "Andrey Volkov" <avolkov@varma-el.com>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Cc: ML linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH 0/6] Change MPC52xx to platform bus / ppc_sys model
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> Hi Sylvain, Dale
>
> Which state of fec ocp -> fec platform conversion?
> Without fec, IMHO, this patches less usable.

Once the platform patches are in bk mainstream, I'll recreate
a BK tree from there containing the fec and bestcomm. If you
want fec now, just use the "old" tree, it's not that old and
works fine. And if you want the newest tree, do the adaptation
youself, changing a driver from ocp to platform is easy ...


   Sylvain
