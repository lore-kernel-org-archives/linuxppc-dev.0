Return-Path: <pku.leo@gmail.com>
Received: from mail-io0-f196.google.com (mail-io0-f196.google.com
 [209.85.223.196])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 420Hnt5lQ7zF09c
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Aug 2018 04:48:15 +1000 (AEST)
Received: by mail-io0-f196.google.com with SMTP id 75-v6so2331912iou.11
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Aug 2018 11:48:15 -0700 (PDT)
Received: from mail-io0-f170.google.com (mail-io0-f170.google.com.
 [209.85.223.170])
 by smtp.gmail.com with ESMTPSA id b14-v6sm772752ioh.47.2018.08.28.11.48.12
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 28 Aug 2018 11:48:12 -0700 (PDT)
Received: by mail-io0-f170.google.com with SMTP id q4-v6so2339164iob.8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Aug 2018 11:48:12 -0700 (PDT)
MIME-Version: 1.0
References: <20180828015252.28511-1-robh@kernel.org>
 <20180828015252.28511-43-robh@kernel.org>
In-Reply-To: <20180828015252.28511-43-robh@kernel.org>
From: Li Yang <leoyang.li@nxp.com>
Date: Tue, 28 Aug 2018 13:48:01 -0500
Message-ID: <CADRPPNRvRKEuV=ZzH6yq6_7COvFSWy2ibAKoEt4YrzES2m9x2Q@mail.gmail.com>
Subject: Re: [PATCH] soc: Convert to using %pOFn instead of device_node.name
To: Rob Herring <robh@kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Zhao Qiang <qiang.zhao@nxp.com>,
 andy.gross@linaro.org, david.brown@linaro.org,
 Heiko Stuebner <heiko@sntech.de>, thierry.reding@gmail.com,
 Jon Hunter <jonathanh@nvidia.com>, Santosh Shilimkar <ssantosh@kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>, linux-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Aug 27, 2018 at 8:57 PM Rob Herring <robh@kernel.org> wrote:
>
> In preparation to remove the node name pointer from struct device_node,
> convert printf users to use the %pOFn format specifier.

Please forgive my ignorance, but what is this format specifier do
exactly?   I cannot find anything listed in the printf specification
matching this.  Is this something newly introduced?

Leo
