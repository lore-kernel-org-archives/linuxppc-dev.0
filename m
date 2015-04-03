Return-Path: <curieux.khetan@gmail.com>
Received: from mail-ob0-x22d.google.com (mail-ob0-x22d.google.com
 [IPv6:2607:f8b0:4003:c01::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E44161A03D6
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Apr 2015 17:24:43 +1100 (AEDT)
Received: by obbfy7 with SMTP id fy7so75523365obb.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Apr 2015 23:24:39 -0700 (PDT)
MIME-Version: 1.0
Date: Fri, 3 Apr 2015 11:54:39 +0530
Message-ID: <CAERE9Pqkpshru9=teOXiv9wG4c=ngK6=TQpTo+fQPxo_Y6aTUg@mail.gmail.com>
Subject: PCIE Switch Bringup Problem
From: Ashish Khetan <curieux.khetan@gmail.com>
To: kernelnewbies <kernelnewbies@kernelnewbies.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "scottwood@freescale.com" <scottwood@freescale.com>,
 Sanjeev Sharma <sanjeevsharmaengg@gmail.com>,
 Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
Content-Type: multipart/alternative; boundary=001a11c1f5eecdf25b0512cc0089
Cc: ashishk@vrindatech.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--001a11c1f5eecdf25b0512cc0089
Content-Type: text/plain; charset=UTF-8

Hi, I am using MPC8640D based powerpc board. I am trying to bringup PCIe
switch(PES64H16AG2) using linux BSP(Linux-3.14).
After Power on reset its unable detect to detect any link on PCIe BUS.
While on another bus PCIe link is detected which is not another PCIe device.


 Any debugging points/link will be really helpful.


Regards
@$HI$H

--001a11c1f5eecdf25b0512cc0089
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div>Hi, I am using MPC8640D based powerpc board=
. I am trying to bringup PCIe switch(PES64H16AG2) using linux BSP(Linux-3.1=
4).<br></div>After Power on reset its unable detect to detect any link on P=
CIe BUS. While on another bus PCIe link is detected which is not another PC=
Ie device.<br><br><br>=C2=A0Any debugging points/link will be really helpfu=
l.<br><br><br></div>Regards <br></div>@$HI$H<br></div>

--001a11c1f5eecdf25b0512cc0089--
