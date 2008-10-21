Return-Path: <AymanE@tanisys.com>
Received: from tanisys-ex2.Tanisys.Local (mail.tanisys.com [206.127.28.197])
	by ozlabs.org (Postfix) with ESMTP id 23609DDDEA
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Oct 2008 01:36:41 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [RFC/PATCH] pci: Workaround invalid P2P bridge bus numbers
Date: Tue, 21 Oct 2008 09:36:38 -0500
Message-ID: <16691A8B34B5D9458EA3A1C37A11555A0137F833@tanisys-ex2.Tanisys.Local>
In-Reply-To: <20081020230717.2FD16DDDDB@ozlabs.org>
References: <20081020230717.2FD16DDDDB@ozlabs.org>
From: "Ayman El-Khashab" <AymanE@tanisys.com>
To: <linuxppc-dev@ozlabs.org>
Cc: linux-pci@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:

>=20
> Ayman, can you double check that this variant of the patch still
> fixes your problem ? Thanks !
>=20

I've tried it out and it is working correctly with my devices.  The
subordinate bus numbers on all the ports are correct.

Best Regards,
Ayman
