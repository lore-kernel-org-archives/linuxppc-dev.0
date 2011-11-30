Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id B603D1007D1
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Dec 2011 08:03:29 +1100 (EST)
Message-ID: <1322686997.29041.11.camel@pasglop>
Subject: Re: [PATCH v2] powerpc/40x: Add APM8018X SOC support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Tanmay Inamdar <tinamdar@apm.com>
Date: Thu, 01 Dec 2011 08:03:17 +1100
In-Reply-To: <1322550101-28520-1-git-send-email-tinamdar@apm.com>
References: <1322550101-28520-1-git-send-email-tinamdar@apm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2011-11-29 at 12:31 +0530, Tanmay Inamdar wrote:
> The AppliedMicro APM8018X embedded processor targets embedded applications that
> require low power and a small footprint. It features a PowerPC 405 processor
> core built in a 65nm low-power CMOS process with a five-stage pipeline executing
> up to one instruction per cycle. The family has 128-kbytes of on-chip memory,
> a 128-bit local bus and on-chip DDR2 SDRAM controller with 16-bit interface.

Thanks, looks much better.

Cheers,
Ben.
