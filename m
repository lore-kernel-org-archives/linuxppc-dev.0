Return-Path: <vgallardo@amcc.com>
Received: from sdcmail02.amcc.com (sdcmail02.amcc.com [198.137.200.73])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "Messaging Gateway Appliance Demo Cert",
	Issuer "Messaging Gateway Appliance Demo Cert" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id B96E0474C3
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Nov 2008 05:29:49 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: [PATCH] ibm_newemac: Add support for Arches CPU0 SGMII0 to CPU1
	SGMII0
Date: Tue, 4 Nov 2008 10:29:41 -0800
Message-ID: <0CA0A16855646F4FA96D25A158E299D60546CA64@SDCEXCHANGE01.ad.amcc.com>
In-Reply-To: <1225573402-28113-1-git-send-email-vgallardo@amcc.com>
From: "Victor Gallardo" <vgallardo@amcc.com>
To: "Josh Boyer" <jwboyer@linux.vnet.ibm.com>,
	<linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

=20
Hello Josh,

Have you had a chance to look at this patch.

> On Arches, SGMII0 Rx/Tx on CPU0 is wired to SGMII0 Tx/Rx on CPU1.
> Add GPCS as a phy type to allow for this.

Regards,

Victor Gallardo
