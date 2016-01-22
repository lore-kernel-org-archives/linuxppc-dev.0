Return-Path: <pku.leo@gmail.com>
Received: from mail-wm0-x22f.google.com (mail-wm0-x22f.google.com
 [IPv6:2a00:1450:400c:c09::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47D231A0019
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jan 2016 20:15:35 +1100 (AEDT)
Received: by mail-wm0-x22f.google.com with SMTP id r129so204746835wmr.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jan 2016 01:15:35 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1453338364-45129-1-git-send-email-qiang.zhao@nxp.com>
References: <1453338364-45129-1-git-send-email-qiang.zhao@nxp.com>
Date: Fri, 22 Jan 2016 17:15:31 +0800
Message-ID: <CADRPPNSMn=hqqJ8j_5D8WGpbxo-dw-XV_vHkQ1zxJymT7rspLQ@mail.gmail.com>
Subject: Re: [PATCH] qe_ic: fix a buffer overflow error and add check elsewhere
From: Leo Li <pku.leo@gmail.com>
To: Zhao Qiang <qiang.zhao@nxp.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 lkml <linux-kernel@vger.kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Li Yang <leoyang.li@nxp.com>,
 oss@buserror.net, xiaobo.xie@nxp.com
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jan 21, 2016 at 9:06 AM, Zhao Qiang <qiang.zhao@nxp.com> wrote:
> 127 is the theoretical up boundary of QEIC number,
> in fact there only be 44 qe_ic_info now.
> add check to overflow for qe_ic_info
>
> Signed-off-by: Zhao Qiang <qiang.zhao@nxp.com>

Acked-by: Li Yang <leoyang.li@nxp.com>

Regards,
Leo
