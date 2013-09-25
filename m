Return-Path: <richardcochran@gmail.com>
Received: from mail-ea0-x233.google.com (mail-ea0-x233.google.com
 [IPv6:2a00:1450:4013:c01::233])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B7D7C2C00BA
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Sep 2013 03:13:51 +1000 (EST)
Received: by mail-ea0-f179.google.com with SMTP id b10so3297911eae.24
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Sep 2013 10:13:47 -0700 (PDT)
Date: Wed, 25 Sep 2013 19:13:38 +0200
From: Richard Cochran <richardcochran@gmail.com>
To: Aida Mynzhasova <aida.mynzhasova@skitlab.ru>
Subject: Re: [PATCH v2] powerpc/83xx: gianfar_ptp: select 1588 clock source
 through dts file
Message-ID: <20130925170904.GC4333@netboy>
References: <1380093863-5388-1-git-send-email-aida.mynzhasova@skitlab.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1380093863-5388-1-git-send-email-aida.mynzhasova@skitlab.ru>
Cc: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Sep 25, 2013 at 11:24:23AM +0400, Aida Mynzhasova wrote:
> Currently IEEE 1588 timer reference clock source is determined through
> hard-coded value in gianfar_ptp driver. This patch allows to select ptp
> clock source by means of device tree file node.

Looks okay to me now.

Acked-by: Richard Cochran <richardcochran@gmail.com>
