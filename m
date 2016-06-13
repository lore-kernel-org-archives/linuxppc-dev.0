Return-Path: <daniel.lezcano@linaro.org>
Received: from mail-wm0-x233.google.com (mail-wm0-x233.google.com
 [IPv6:2a00:1450:400c:c09::233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rSwwj47BczDqZv
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jun 2016 01:01:56 +1000 (AEST)
Received: by mail-wm0-x233.google.com with SMTP id n184so82684823wmn.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jun 2016 08:01:56 -0700 (PDT)
Date: Mon, 13 Jun 2016 17:01:50 +0200
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
Cc: mpe@ellerman.id.au, benh@au1.ibm.com, paulus@ozlabs.org,
 mikey@neuling.org, ego@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v6 09/11] cpuidle/powernv: Use CPUIDLE_STATE_MAX instead
 of MAX_POWERNV_IDLE_STATES
Message-ID: <20160613150150.GE10634@linaro.org>
References: <1465404871-5406-1-git-send-email-shreyas@linux.vnet.ibm.com>
 <1465404871-5406-10-git-send-email-shreyas@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1465404871-5406-10-git-send-email-shreyas@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 08, 2016 at 11:54:29AM -0500, Shreyas B. Prabhu wrote:
> Use cpuidle's CPUIDLE_STATE_MAX macro instead of powernv specific
> MAX_POWERNV_IDLE_STATES.
> 
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: linux-pm@vger.kernel.org
> Suggested-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Signed-off-by: Shreyas B. Prabhu <shreyas@linux.vnet.ibm.com>
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
