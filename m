Return-Path: <alessio.bogani@elettra.eu>
Received: from spamalot.elettra.eu (spamalot.elettra.trieste.it
 [140.105.206.208])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BAE7D1A006D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Feb 2016 01:40:09 +1100 (AEDT)
Received: from spamalot.elettra.eu (localhost.localdomain [127.0.0.1])
 by localhost (Email Security Appliance) with SMTP id A1B49440EC6_6BB4BC4B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Feb 2016 14:40:04 +0000 (GMT)
Received: from mail-qg0-f54.google.com (mail-qg0-f54.google.com
 [209.85.192.54])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (verified OK))
 by spamalot.elettra.eu (Sophos Email Appliance) with ESMTPSA id
 60C6C43E082_6BB4BC3F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Feb 2016 14:40:03 +0000 (GMT)
Received: by mail-qg0-f54.google.com with SMTP id b67so14723417qgb.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Feb 2016 06:40:03 -0800 (PST)
MIME-Version: 1.0
Date: Wed, 10 Feb 2016 15:40:01 +0100
Message-ID: <CAPk1OjEAMaZjup2UWmtibyDtM1qSH7OuKQqgLV4iDnBm5gF_8g@mail.gmail.com>
Subject: mpc8641si-pre.dtsi and mpc8641si-post.dtsi
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

Hi Kumar, Scott and all,

I'm wondering if actual make sense create files in subject to
consolidate five device tree (gef_ppc9a.dts, gef_sbc310.dts,
gef_sbc610.dts, mpc8641_hpcn.dts and sbc8641d.dts). If it makes sense
what device tree can I take as example?

Thank you very much!

Ciao,
Alessio
