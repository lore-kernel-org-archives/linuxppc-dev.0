Return-Path: <pku.leo@gmail.com>
Received: from mail-it0-x231.google.com (mail-it0-x231.google.com
 [IPv6:2607:f8b0:4001:c0b::231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zCMkN210bzDqvc
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Jan 2018 09:22:52 +1100 (AEDT)
Received: by mail-it0-x231.google.com with SMTP id d16so4090566itj.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 Jan 2018 14:22:52 -0800 (PST)
MIME-Version: 1.0
From: Yang Li <pku.leo@gmail.com>
Date: Thu, 4 Jan 2018 16:22:49 -0600
Message-ID: <CADRPPNRVb_CGBesSD6zQcPmrATxqSHhSmywAEfTT7jqpioNaGg@mail.gmail.com>
Subject: Anyone working on the KPTI support for powerpc?
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I assume some of the powerpc platforms would be impacted by the newly
announced meltdown/spetre vulnerabilities.  It will be good if we have
an aligned implementation of the KPTI.

Regards,
Leo
