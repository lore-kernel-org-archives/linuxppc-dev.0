Return-Path: <robherring2@gmail.com>
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com
 [IPv6:2607:f8b0:4864:20::742])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Blqb0ZJBzF3Yx
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Sep 2018 05:26:02 +1000 (AEST)
Received: by mail-qk1-x742.google.com with SMTP id z78-v6so5807536qka.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Sep 2018 12:26:02 -0700 (PDT)
MIME-Version: 1.0
From: Rob Herring <robherring2@gmail.com>
Date: Fri, 14 Sep 2018 14:25:48 -0500
Message-ID: <CAL_JsqJmyiAOAvEhWxBy11xw==m5kqg_V90CCLPV1PqGDuHD7w@mail.gmail.com>
Subject: [GIT PULL] Devicetree fix for 4.19-rc
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, devicetree@vger.kernel.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Frank Rowand <frowand.list@gmail.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Linus,

Please pull. One regression for a 20 year old PowerMac.

Rob

The following changes since commit 0413bedabc886c3a56804d1c80a58e99077b1d91:

  of: Add device_type access helper functions (2018-08-31 08:30:42 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git
tags/devicetree-fixes-for-4.19-2

for you to fetch changes up to e54192b48da75f025ae4b277925eaf6aca1d13bd:

  of: fix phandle cache creation for DTs with no phandles (2018-09-11
11:28:40 -0500)

----------------------------------------------------------------
Devicetree fixes for 4.19, part 2:

- Fix a regression on systems having a DT without any phandles which
  happens on a PowerMac G3.

----------------------------------------------------------------
Rob Herring (1):
      of: fix phandle cache creation for DTs with no phandles

 drivers/of/base.c | 3 +++
 1 file changed, 3 insertions(+)
