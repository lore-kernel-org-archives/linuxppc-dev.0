Return-Path: <sebastian.huber@embedded-brains.de>
Received: from dedi548.your-server.de (dedi548.your-server.de [85.10.215.148])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r3GCW0yd6zDq64
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 May 2016 18:44:39 +1000 (AEST)
To: linuxppc-dev@lists.ozlabs.org
From: Sebastian Huber <sebastian.huber@embedded-brains.de>
Subject: Status of DPAA integration for NXP QoriQ?
Cc: Igal Liberman <igal.liberman@freescale.com>
Message-ID: <57304A64.1020607@embedded-brains.de>
Date: Mon, 9 May 2016 10:29:24 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

the "fman" Ethernet driver was integrated in mainline Linux Dezember=20
2015 ("drivers/net/ethernet/freescale/fman"). It seems that the other=20
parts, e.g. BMan, QMan ("drivers/soc/fsl/qbman") and basic DPAA Ethernet=20
support ("drivers/net/ethernet/freescale/dpaa") are still missing. Are=20
there any plans to integrate them? I didn't notice any activity on the=20
mailing list in the last couple of months in this respect.

--=20
Sebastian Huber, embedded brains GmbH

Address : Dornierstr. 4, D-82178 Puchheim, Germany
Phone   : +49 89 189 47 41-16
Fax     : +49 89 189 47 41-09
E-Mail  : sebastian.huber@embedded-brains.de
PGP     : Public key available on request.

Diese Nachricht ist keine gesch=C3=A4ftliche Mitteilung im Sinne des EHUG=
.
