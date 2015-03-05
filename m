Return-Path: <jhs@mojatatu.com>
Received: from mail-ig0-f174.google.com (mail-ig0-f174.google.com
 [209.85.213.174])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 752741A0007
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Mar 2015 23:32:54 +1100 (AEDT)
Received: by igbhl2 with SMTP id hl2so45201930igb.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Mar 2015 04:32:51 -0800 (PST)
Message-ID: <54F84CF1.80702@mojatatu.com>
Date: Thu, 05 Mar 2015 07:32:49 -0500
From: Jamal Hadi Salim <jhs@mojatatu.com>
MIME-Version: 1.0
To: Emil Medve <Emilian.Medve@Freescale.com>,
 linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] Freescale DPAA FMan FLIB(s)
References: <1425534351-1065-1-git-send-email-Emilian.Medve@Freescale.com>
In-Reply-To: <1425534351-1065-1-git-send-email-Emilian.Medve@Freescale.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Cc: Igal Liberman <Igal.Liberman@Freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/05/15 00:45, Emil Medve wrote:
> From: Igal Liberman <Igal.Liberman@freescale.com>
>
> The Freescale Data Path Acceleration Architecture (DPAA) is a set of
> hardware components on specific QorIQ P and T series multicore processors.
> This architecture provides the infrastructure to support simplified
> sharing of networking interfaces and accelerators by multiple CPU cores,
> and the accelerators themselves.
>
> One of the DPAA accelerators is the Frame Manager (FMan), which
> combines the Ethernet network interfaces with packet distribution
> logic to provide intelligent distribution and queuing decisions for
> incoming traffic at line rate.
>
> This patch presents the FMan Foundation Libraries (FLIB) headers.
> The FMan FLIB suite adds basic support for the DPAA FMan hardware register access.
> The FMan FLIB suite is used in Freescale's SDK Releases.
>

Is this intended to merely enable your sdk? How are you planning to
add support for your classifiers, queue schedulers etc? Is that a patch
on top of this or it is something that sits on user space?

cheers,
jamal
