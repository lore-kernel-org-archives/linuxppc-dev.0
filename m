Return-Path: <robh@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41wm3W6z9YzF0gv
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Aug 2018 10:47:48 +1000 (AEST)
Received: from mail-qk0-f171.google.com (mail-qk0-f171.google.com
 [209.85.220.171])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 94EF620A8B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Aug 2018 00:47:46 +0000 (UTC)
Received: by mail-qk0-f171.google.com with SMTP id c126-v6so2555716qkd.7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Aug 2018 17:47:46 -0700 (PDT)
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
Date: Wed, 22 Aug 2018 19:47:34 -0500
Message-ID: <CAL_Jsq+XacT2O15CQ=F_6dmWf6OqNf8_fKAOrMJNR79a6mORaw@mail.gmail.com>
Subject: DT case sensitivity
To: Stephen Rothwell <sfr@canb.auug.org.au>,
 Grant Likely <grant.likely@arm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Kumar Gala <kumar.gala@linaro.org>, David Gibson <david@gibson.dropbear.id.au>,
 Frank Rowand <frowand.list@gmail.com>, devicetree-spec@vger.kernel.org,
 devicetree@vger.kernel.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The default DT string handling in the kernel is node names and
compatibles are case insensitive and property names are case sensitive
(Sparc is the the only variation and is opposite). It seems only PPC
(and perhaps only Power Macs?) needs to support case insensitive
comparisons. It was probably a mistake to follow PPC for new arches
and we should have made everything case sensitive from the start. So I
have a few questions for the DT historians. :)

What PPC systems are case insensitive? Can we limit that to certain systems?

AFAICT, dtc at least (if not anything FDT based) has always been case
sensitive at least for node and property names. I'm not sure about
compatible strings?

Anyone see potential issues with switching all platforms except PPC
and Sparc to case sensitive comparisons?

Rob
