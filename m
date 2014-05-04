Return-Path: <chzigotzky@xenosoft.de>
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de
 [81.169.146.220])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 72F1314018F
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 May 2014 02:08:57 +1000 (EST)
Received: from [192.168.1.139] (ppp-93-104-77-63.dynamic.mnet-online.de
 [93.104.77.63]) by smtp.strato.de (RZmta 32.39 DYNA|AUTH)
 with ESMTPSA id i04e32q44G2dsbT
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 for <linuxppc-dev@lists.ozlabs.org>;
 Sun, 4 May 2014 18:02:39 +0200 (CEST)
Message-ID: <5366649E.4030102@xenosoft.de>
Date: Sun, 04 May 2014 18:02:38 +0200
From: Christian Zigotzky <chzigotzky@xenosoft.de>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: Boot problems with a PA6T board
Content-Type: text/plain; charset=UTF-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi All,

The RC 1, 2, and 3 of the kernel 3.15 don't boot on my PA6T board with a 
Radeon HD 6870 graphics card.

Screenshot: 
http://forum.hyperion-entertainment.biz/download/file.php?id=1060&mode=view

The kernel 3.14 starts without any problems. Has anyone a tip for me, 
please?

Cheers,

Christian
