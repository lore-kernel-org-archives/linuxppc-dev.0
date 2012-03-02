Return-Path: <jgpobox@gmail.com>
Received: from mail-vx0-f179.google.com (mail-vx0-f179.google.com
 [209.85.220.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 99B3DB6EF3
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Mar 2012 07:46:55 +1100 (EST)
Received: by vcbf11 with SMTP id f11so799320vcb.38
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Mar 2012 12:46:52 -0800 (PST)
Sender: Jeff Garzik <jgpobox@gmail.com>
Message-ID: <4F5131B9.6010803@pobox.com>
Date: Fri, 02 Mar 2012 15:46:49 -0500
From: Jeff Garzik <jgarzik@pobox.com>
MIME-Version: 1.0
To: Liu Qiang-B32616 <B32616@freescale.com>
Subject: Re: [PATCH V3] fsl-sata: add support for interrupt coalsecing feature
References: <1329291634-883-1-git-send-email-qiang.liu@freescale.com>
 <CADRPPNTmRvPVymJmW4vagU+2M4DmqeDSEj=4=R_=YDJekOTccQ@mail.gmail.com>
 <BCB48C05FCE8BC4D9E61E841ECBE6DB70424A8@039-SN2MPN1-012.039d.mgd.msft.net>
In-Reply-To: <BCB48C05FCE8BC4D9E61E841ECBE6DB70424A8@039-SN2MPN1-012.039d.mgd.msft.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Li Yang-R58472 <r58472@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/28/2012 09:54 PM, Liu Qiang-B32616 wrote:
> Hi Jeff,
>
> Do you plan to apply it to upstream, or any suggestions? Thanks.

This patch has been in libata-dev (and thus linux-next) for about 2 weeks...
