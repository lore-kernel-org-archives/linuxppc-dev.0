Return-Path: <yorksun@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0122.outbound.protection.outlook.com [65.55.169.122])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6EEC41A0DBB
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Jan 2015 04:23:36 +1100 (AEDT)
Message-ID: <54B7F414.2020609@freescale.com>
Date: Thu, 15 Jan 2015 09:08:36 -0800
From: York Sun <yorksun@freescale.com>
MIME-Version: 1.0
To: Dongsheng Wang <dongsheng.wang@freescale.com>, <scottwood@freescale.com>,
 <leoli@freescale.com>
Subject: Re: [PATCH] fsl/smp: add low power boot support to replace spin boot
References: <1421301930-10035-1-git-send-email-dongsheng.wang@freescale.com>
In-Reply-To: <1421301930-10035-1-git-send-email-dongsheng.wang@freescale.com>
Content-Type: text/plain; charset="windows-1252"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 01/14/2015 10:05 PM, Dongsheng Wang wrote:
> From: Wang Dongsheng <dongsheng.wang@freescale.com>
> 
> U-boot put non-boot cpus into an low power state(PW10/PW20 or DOZE) when cpu
> powered up. To exit low power state kernel will send DOORBELL or MPIC-IPI
> signal to all those CPUs.
> 
> e500/e500v2 use mpic to send IPI signal.
> e500mc and later use doorbell to send IPI signal.
> 
> This feature tested on:
> POWER UP TEST:
> P1022DS(e500v2),96k times.
> P4080(e500mc),  110k times.
> T1024(e5500),   83k times.
> T4240(e6500),   150k times.
> 
> CPU HOTPLUG TEST:
> P1022DS(e500v2),1.4 million times.
> P4080(e500mc),  1.8 million times.
> T1024(e5500),   1.3 million times.
> T4240(e6500),   1.1 million times.
> 
> Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>
> 

This is a very good move. Can you explain what has been tested for 100K times,
or over a million times?

Have you verified on older e500v2 platforms, such as MPC8572?

York
