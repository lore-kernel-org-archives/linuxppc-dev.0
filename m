Return-Path: <pku.leo@gmail.com>
Received: from mail-wm0-x243.google.com (mail-wm0-x243.google.com
 [IPv6:2a00:1450:400c:c09::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6751D1A004E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Jan 2016 20:10:07 +1100 (AEDT)
Received: by mail-wm0-x243.google.com with SMTP id l65so15252517wmf.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Jan 2016 01:10:07 -0800 (PST)
MIME-Version: 1.0
Sender: pku.leo@gmail.com
In-Reply-To: <1452219494-31947-3-git-send-email-qiang.zhao@nxp.com>
References: <1452219494-31947-1-git-send-email-qiang.zhao@nxp.com>
 <1452219494-31947-3-git-send-email-qiang.zhao@nxp.com>
Date: Mon, 18 Jan 2016 17:10:00 +0800
Message-ID: <CADRPPNS3qT+=zz60UKRSYwxpaphcE7e04SntOQ==RjoOfhQ68Q@mail.gmail.com>
Subject: Re: [PATCH 3/6] QE: Add uqe_serial document to bindings
From: Li Yang <leoli@freescale.com>
To: Zhao Qiang <qiang.zhao@nxp.com>
Cc: devicetree@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Priyanka.Jain@freescale.com,
 oss@buserror.net
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jan 8, 2016 at 10:18 AM, Zhao Qiang <qiang.zhao@nxp.com> wrote:
> Add uqe_serial document to
> Documentation/devicetree/bindings/powerpc/fsl/cpm_qe/uqe_serial.txt

As you have submitted patch to move QE code from arch/powerpc into
drivers/soc/fsl for the reuse of ARM and powerpc,  you should also
move the binding documents out of the powerpc folder into a more
common place and add new bindings in the new location.

Regards,
Leo
