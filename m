Return-Path: <sboyd@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 420Nx248sPzF0QC
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Aug 2018 08:39:50 +1000 (AEST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: Vabhav Sharma <vabhav.sharma@nxp.com>, arnd@arndb.de,
 catalin.marinas@arm.com,
 devicetree@vger.kernel.org, gregkh@linuxfoundation.org,
 kstewart@linuxfoundation.org, linux-arm-kernel@lists.infradead.org,
 linux-clk@vger.kernel.org, linux-kernel-owner@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, mark.rutland@arm.com, mturquette@baylibre.com,
 rjw@rjwysocki.net, robh+dt@kernel.org, viresh.kumar@linaro.org,
 will.deacon@arm.com, yamada.masahiro@socionext.com
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1534747636-20064-4-git-send-email-vabhav.sharma@nxp.com>
Cc: linux@armlinux.org.uk, V.Sethi@nxp.com, udit.kumar@nxp.com,
 Yogesh Gaur <yogeshnarayan.gaur@nxp.com>, Tang Yuantian <andy.tang@nxp.com>,
 Vabhav Sharma <vabhav.sharma@nxp.com>
References: <1534747636-20064-1-git-send-email-vabhav.sharma@nxp.com>
 <1534747636-20064-4-git-send-email-vabhav.sharma@nxp.com>
Message-ID: <153549598745.129321.12633089552143824401@swboyd.mtv.corp.google.com>
Subject: Re: [PATCH 3/5] drivers: clk-qoriq: Add clockgen support for lx2160a
Date: Tue, 28 Aug 2018 15:39:47 -0700
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Quoting Vabhav Sharma (2018-08-19 23:47:14)
> From: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
> =

> Add clockgen support for lx2160a.
> Added entry for compat 'fsl,lx2160a-clockgen'.
> As LX2160A is 16 core, so modified value for NUM_CMUX
> =

> Signed-off-by: Tang Yuantian <andy.tang@nxp.com>
> Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
> Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>
