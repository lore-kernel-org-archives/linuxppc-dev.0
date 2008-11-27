Return-Path: <andre.schwarz@matrix-vision.de>
Received: from p15137414.pureserver.info (matrixvision.de [217.160.213.229])
	by ozlabs.org (Postfix) with ESMTP id EEF9EDDDD8
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Nov 2008 02:00:27 +1100 (EST)
Received: from pandora.intern.matrix-vision.de (g1.matrix-vision.com
	[217.7.222.190])
	by p15137414.pureserver.info (Postfix) with ESMTP id EAACD3CC068
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Nov 2008 16:00:25 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by pandora.intern.matrix-vision.de (Postfix) with ESMTP id 7EA20E3C09
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Nov 2008 18:00:27 +0100 (CET)
Received: from hegemone (hegemone.intern.matrix-vision.de [192.168.5.77])
	by pandora.intern.matrix-vision.de (Postfix) with ESMTP id 0D259E3C09
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Nov 2008 18:00:24 +0100 (CET)
Received: from [192.168.65.5] (unknown [192.168.65.5])
	by hegemone (Postfix) with ESMTP id 106E651E
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Nov 2008 17:56:34 +0100 (CET)
Message-ID: <492EB606.9020703@matrix-vision.de>
Date: Thu, 27 Nov 2008 16:00:22 +0100
From: Andre Schwarz <andre.schwarz@matrix-vision.de>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: i2c-mpc clocking scheme 
Content-Type: text/plain; charset=ISO-8859-15
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

All,

is anybody working on some improvements regarding configurable I2C
frequency inside the i2c-mpc driver ?

If not - would anybody be intersted in getting this done, i.e.
configurable via device tree ?



regards,
Andre

MATRIX VISION GmbH, Talstraße 16, DE-71570 Oppenweiler  - Registergericht: Amtsgericht Stuttgart, HRB 271090
Geschäftsführer: Gerhard Thullner, Werner Armingeon, Uwe Furtner
