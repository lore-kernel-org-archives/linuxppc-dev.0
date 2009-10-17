Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C2E05B7334
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Oct 2009 23:18:27 +1100 (EST)
Received: from sesr04.transmode.se (sesr04.transmode.se [192.168.201.15])
	by gw1.transmode.se (Postfix) with ESMTP id 59A26650002
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Oct 2009 14:18:24 +0200 (CEST)
Subject: Mixing hard and soft floating point?
To: linuxppc-dev@ozlabs.org
Message-ID: <OFC920E57F.DFABC29F-ONC1257652.00421E11-C1257652.0043478A@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Sat, 17 Oct 2009 14:14:52 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Anyone tried mixing hard and soft FP in on soft float CPU such as 83xx?

Been trying to figure out if this is a good idea or not.
Any combinations that will or won't work?

Generally I got soft FP in all system libs but there might be
an binary application which will use hard FP.
Is the MATH_EMU option in the kernel reliable(for 8xx too)?

 Jocke
