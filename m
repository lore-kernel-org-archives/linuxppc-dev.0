Return-Path: <B07421@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 1488EB6EDF
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Nov 2009 06:25:25 +1100 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	nADJPMVq007587
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Nov 2009 12:25:23 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id nADJPNDd024268
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Nov 2009 13:25:23 -0600 (CST)
Message-ID: <4AFDB2BC.6020101@freescale.com>
Date: Fri, 13 Nov 2009 13:25:48 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Joakim Tjernlund <joakim.tjernlund@transmode.com>
Subject: Re: [PATCH 0/8] 8xx: Misc fixes for buggy insn
References: <4AF99695.800@freescale.com> <4AF99B00.6080504@freescale.com>
	<OFDB4F927C.98657449-ONC125766A.006874A4-C125766A.00692F0B@transmode.se>
	<4AF9CC99.1030500@freescale.com>
	<OFDF13AF8E.1B38CEA9-ONC125766A.0073E59F-C125766A.0075ABE6@transmode.se>
	<4AF9DCE0.4030805@freescale.com>
	<OF15D21C1C.B7A920F0-ONC125766A.0076C36E-C125766A.0077B321@transmode.se>
	<4AF9E2E2.7030100@freescale.com> <4AF9F56E.9080104@freescale.com>
	<OF2843D474.207958C1-ONC125766A.00828F87-C125766B.00009091@transmode.se>
	<20091111152653.GA688@loki.buserror.net>
	<OFE47A9BB7.59140781-ONC125766C.00322B87-C125766C.003266AD@transmode.se>
	<4AFC65F7.4050600@freescale.com>
	<OFF2FA2BCA.A6C0CAA9-ONC125766C.0074494F-C125766C.0074AF53@transmode.se>
	<4AFC84E7.6050706@freescale.com>
	<OF9A8AE2F7.5F8AC107-ONC125766C.008051C5-C125766C.00810B6D@transmode.se>
In-Reply-To: <OF9A8AE2F7.5F8AC107-ONC125766C.008051C5-C125766C.00810B6D@transmode.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Rex Feany <RFeany@mrv.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Joakim Tjernlund wrote:
> Anyhow, lets start simple and just do the pinned ITLB so the
> new TLB code can be applied. Can you confirm this works for you?

It works (after changing #ifdef 1 to #if 1).

-Scott
