Return-Path: <frowand.list@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wtF705ytKzDqj1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jun 2017 05:25:48 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id y7so32510066pfd.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jun 2017 12:25:48 -0700 (PDT)
Subject: Re: [PATCH v6 1/4] of: remove *phandle properties from expanded
 device tree
To: Michael Ellerman <mpe@ellerman.id.au>, Rob Herring <robh+dt@kernel.org>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
References: <1497996172-821-1-git-send-email-frowand.list@gmail.com>
 <1497996172-821-2-git-send-email-frowand.list@gmail.com>
 <87mv92szsw.fsf@concordia.ellerman.id.au> <594A0FB6.2000102@gmail.com>
Cc: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
From: Frank Rowand <frowand.list@gmail.com>
Message-ID: <594AC838.5010901@gmail.com>
Date: Wed, 21 Jun 2017 12:25:44 -0700
MIME-Version: 1.0
In-Reply-To: <594A0FB6.2000102@gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/20/17 23:18, Frank Rowand wrote:
> Hi Rob,
> 
> Michael has an issue that means this patch series is not OK in the
> current form.  I will work on a v7 to see if I can resolve the
> issue.
> 
> -Frank

< snip >

Hi Rob,

The issue is in patch 1.  Patches 2 - 4 are small independent patches
that are not dependent on patch 1, so I just sent them as individual
patches.  Version 7 of this series will be just patch 1.

-Frank
