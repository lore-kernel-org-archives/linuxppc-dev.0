Return-Path: <dan.j.williams@gmail.com>
Received: from mail-qc0-f179.google.com (mail-qc0-f179.google.com
 [209.85.216.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id BBEF42C0089
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Aug 2012 06:01:49 +1000 (EST)
Received: by qcse14 with SMTP id e14so663220qcs.38
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Aug 2012 13:01:46 -0700 (PDT)
MIME-Version: 1.0
Sender: dan.j.williams@gmail.com
In-Reply-To: <BCB48C05FCE8BC4D9E61E841ECBE6DB70E3D47@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1344500375-8457-1-git-send-email-qiang.liu@freescale.com>
 <20120809170307.GG14264@ovro.caltech.edu>
 <BCB48C05FCE8BC4D9E61E841ECBE6DB70E3D47@039-SN2MPN1-013.039d.mgd.msft.net>
Date: Tue, 14 Aug 2012 13:01:46 -0700
Message-ID: <CAA9_cme4tHrx14JaSaHwgcGq79qQK5bv8E205fbC3ega5OpUiQ@mail.gmail.com>
Subject: Re: [PATCH v7 0/8] Raid: enable talitos xor offload for improving
 performance
From: Dan Williams <djbw@fb.com>
To: Liu Qiang-B32616 <B32616@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
 "arnd@arndb.de" <arnd@arndb.de>, "Ira W. Snyder" <iws@ovro.caltech.edu>,
 "vinod.koul@intel.com" <vinod.koul@intel.com>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
 "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Aug 14, 2012 at 2:04 AM, Liu Qiang-B32616 <B32616@freescale.com> wrote:
> Hi Vinod,
>
> Would you like to apply this series from patch 2/8 to 7/8) in your tree?
> The link as below,
> http://patchwork.ozlabs.org/patch/176023/
> http://patchwork.ozlabs.org/patch/176024/
> http://patchwork.ozlabs.org/patch/176025/
> http://patchwork.ozlabs.org/patch/176026/
> http://patchwork.ozlabs.org/patch/176027/
> http://patchwork.ozlabs.org/patch/176028/
>

Hi, sorry for the recent silence I've been transitioning and am now
just catching up.  I'll take a look and then it's fine for these to go
through Vinod's tree.

--
Dan
