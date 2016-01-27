Return-Path: <alessio.bogani@elettra.eu>
Received: from spamalot.elettra.eu (spamalot.elettra.trieste.it
 [140.105.206.208])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1FF651A0174
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jan 2016 20:24:59 +1100 (AEDT)
Received: from spamalot.elettra.eu (localhost.localdomain [127.0.0.1])
 by localhost (Email Security Appliance) with SMTP id 62A95440E90_6A88CE7B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jan 2016 09:24:55 +0000 (GMT)
Received: from mail-qg0-f54.google.com (mail-qg0-f54.google.com
 [209.85.192.54])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (verified OK))
 by spamalot.elettra.eu (Sophos Email Appliance) with ESMTPSA id
 4259643E093_6A88CE6F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jan 2016 09:24:54 +0000 (GMT)
Received: by mail-qg0-f54.google.com with SMTP id o11so1820174qge.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jan 2016 01:24:54 -0800 (PST)
MIME-Version: 1.0
Date: Wed, 27 Jan 2016 10:24:53 +0100
Message-ID: <CAPk1OjGew2n-17ztcbxcxBXWundeEk5nKQ5MS1HLYR4fiBOjxg@mail.gmail.com>
Subject: Question about 86xx
From: Alessio Igor Bogani <alessio.bogani@elettra.eu>
To: Kumar Gala <galak@kernel.crashing.org>
Cc: Scott Wood <oss@buserror.net>, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Kumar,

I'm wondering if we are allowed to put together configurations of the
86xx base systems (gef_ppc9a_defconfig, gef_sbc310_defconfig,
gef_sbc610_defconfig, mpc8610_hpcd_defconfig, mpc8641_hpcn_defconfig
and sbc8641d_defconfig) into the
mpc86xx_defconfig/mpc86xx_smp_defconfig as like already done for 85xx
ones.

Thank you very much!

Ciao,
Alessio
