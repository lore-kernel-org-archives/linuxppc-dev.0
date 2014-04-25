Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0204.outbound.protection.outlook.com [207.46.163.204])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 204C1140134
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Apr 2014 07:45:58 +1000 (EST)
Message-ID: <1398462328.24575.20.camel@snotra.buserror.net>
Subject: Re: [PATCH v2 1/2] powerpc/pm: add api to get suspend state which
 is STANDBY or MEM
From: Scott Wood <scottwood@freescale.com>
To: Dongsheng Wang <dongsheng.wang@freescale.com>
Date: Fri, 25 Apr 2014 16:45:28 -0500
In-Reply-To: <1398319908-30166-1-git-send-email-dongsheng.wang@freescale.com>
References: <1398319908-30166-1-git-send-email-dongsheng.wang@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, chenhui.zhao@freescale.com,
 jason.jin@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2014-04-24 at 14:11 +0800, Dongsheng Wang wrote:
> From: Wang Dongsheng <dongsheng.wang@freescale.com>
> 
> Add set_pm_suspend_state & pm_suspend_state functions to set/get
> suspend state. When system going to sleep or deep sleep, devices
> can get the system suspend state(STANDBY/MEM) through pm_suspend_state
> function and to handle different situations.
> 
> Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>
> ---
> *v2*
> Move pm api from fsl platform to powerpc general framework.

What is powerpc-specific about this?

-Scott
