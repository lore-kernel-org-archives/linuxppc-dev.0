Return-Path: <leon.woestenberg@gmail.com>
Received: from mail-pv0-f170.google.com (mail-pv0-f170.google.com
	[74.125.83.170]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A1887B6EFF
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Apr 2011 03:00:12 +1000 (EST)
Received: by pvg16 with SMTP id 16so980644pvg.15
	for <linuxppc-dev@ozlabs.org>; Wed, 06 Apr 2011 10:00:09 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 6 Apr 2011 19:00:08 +0200
Message-ID: <BANLkTimXgi26RHHxyBLoN8YqaDy_PL-hGQ@mail.gmail.com>
Subject: known working sata_sil24.c setup on powerpc platforms?
From: Leon Woestenberg <leon.woestenberg@gmail.com>
To: Linux PPC <linuxppc-dev@ozlabs.org>, linux-ide@vger.kernel.org,
	Tejun Heo <htejun@gmail.com>, "Moffett,
	Kyle D" <Kyle.D.Moffett@boeing.com>, Jeff Garzik <jeff@garzik.org>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

after investigating problems with sata_sil24.c on a freescale p2020
soc, I wonder if this driver works on powerpc at all?

Does anyone know of a working setup of sata_sil24 on a big endian
powerpc system?

Regards,
-- 
Leon
