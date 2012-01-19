Return-Path: <matthias.fuchs@esd.eu>
Received: from mo-p05-ob6.rzone.de (mo-p05-ob6.rzone.de
 [IPv6:2a01:238:20a:202:53f5::1])
 (using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 9E0F91007D1
 for <linuxppc-dev@ozlabs.org>; Fri, 20 Jan 2012 08:40:05 +1100 (EST)
Received: from bunny.home (p5B03C256.dip.t-dialin.net [91.3.194.86])
 by smtp.strato.de (fruni mo20) (RZmta 27.5 DYNA|AUTH)
 with (EDH-RSA-DES-CBC3-SHA encrypted) ESMTPA id z07282o0JJo56X
 for <linuxppc-dev@ozlabs.org>; Thu, 19 Jan 2012 22:28:50 +0100 (MET)
Received: from [192.168.2.13] (fox.home [192.168.2.13])
 by bunny.home (Postfix) with ESMTPS id 6B77225100FA
 for <linuxppc-dev@ozlabs.org>; Thu, 19 Jan 2012 22:28:28 +0100 (CET)
Message-ID: <4F188B11.6080403@esd.eu>
Date: Thu, 19 Jan 2012 22:28:49 +0100
From: Matthias Fuchs <matthias.fuchs@esd.eu>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: ata/ide driver for MPC512x
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

do we have an ata/ide driver for MPC512x internal ATA controller?
So something that is compatible to "fsl,mpc5121-pata"?

Matthias
