Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 40DCF1007D4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Nov 2011 03:16:48 +1100 (EST)
Subject: Re: [PATCH] powerpc/40x: Add APM8018X SOC support
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1322041464-20605-1-git-send-email-tinamdar@apm.com>
Date: Wed, 23 Nov 2011 10:16:47 -0600
Message-Id: <24399FB8-956E-4C5A-B153-F77196602062@kernel.crashing.org>
References: <1322041464-20605-1-git-send-email-tinamdar@apm.com>
To: Tanmay Inamdar <tinamdar@apm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Nov 23, 2011, at 3:44 AM, Tanmay Inamdar wrote:

> arch/powerpc/kernel/udbg_16550.c            |   22 +

Would be probably good to split this change into its own patch.

- k
