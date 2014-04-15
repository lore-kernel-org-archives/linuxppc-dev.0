Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0187.outbound.protection.outlook.com [207.46.163.187])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 651A81400D5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Apr 2014 07:11:25 +1000 (EST)
Message-ID: <1397596275.20280.281.camel@snotra.buserror.net>
Subject: Re: [PATCH 2/2] fsl/pci: fix EP device sometimes hangup when system
 resume from sleep
From: Scott Wood <scottwood@freescale.com>
To: Dongsheng Wang <dongsheng.wang@freescale.com>
Date: Tue, 15 Apr 2014 16:11:15 -0500
In-Reply-To: <1397547799-29464-2-git-send-email-dongsheng.wang@freescale.com>
References: <1397547799-29464-1-git-send-email-dongsheng.wang@freescale.com>
 <1397547799-29464-2-git-send-email-dongsheng.wang@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, jason.jin@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-04-15 at 15:43 +0800, Dongsheng Wang wrote:
> From: Wang Dongsheng <dongsheng.wang@freescale.com>
> 
> Root cause is pcie power management state transition need a delay.
> The delay time define in "PCI Bus Power Management Interface Specification".
> 
> D0, D1 or D2 --> D3 need to delay 10ms.
> D3 --> D0 need to delay 10ms.
> 
> Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>

Could you describe the other changes besides the addition of a delay at
the end?

-Scott
