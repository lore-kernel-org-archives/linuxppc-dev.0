Return-Path: <bsingharora@gmail.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vXsjN0pk4zDqJw
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Mar 2017 08:51:36 +1100 (AEDT)
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vXsjM40Rqz9s8N
 for <linuxppc-dev@ozlabs.org>; Wed,  1 Mar 2017 08:51:35 +1100 (AEDT)
Received: by mail-pg0-x242.google.com with SMTP id 25so3107677pgy.3
 for <linuxppc-dev@ozlabs.org>; Tue, 28 Feb 2017 13:51:35 -0800 (PST)
Subject: Re: [PATCH V3 1/2] powerpc: Parse the command line before calling CAS
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>, linuxppc-dev@ozlabs.org
References: <1488261828-19696-1-git-send-email-sjitindarsingh@gmail.com>
Cc: mikey@neuling.org, paulus@samba.org, sam.bobroff@au1.ibm.com
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <e70bfa33-6001-9135-5d78-ba98e7742d23@gmail.com>
Date: Wed, 1 Mar 2017 08:51:13 +1100
MIME-Version: 1.0
In-Reply-To: <1488261828-19696-1-git-send-email-sjitindarsingh@gmail.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 28/02/17 17:03, Suraj Jitindar Singh wrote:
> On POWER9 the hypervisor requires the guest to decide whether it would
> like to use a hash or radix mmu model at the time it calls
> ibm,client-architecture-support (CAS) based on what the hypervisor has
> said it's allowed to do. It is possible to disable radix by passing
> "disable_radix" on the command line. The next patch will add support for
> the new CAS format, thus we need to parse the command line before calling
> CAS so we can correctly select which mmu we would like to use.
> 
> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
> Reviewed-by: Paul Mackerras <paulus@ozlabs.org>
> 
> ---
> 
> V1 -> V3:
>  - Reword commit message for clarity. No functional change
> ---

Acked-by: Balbir Singh <bsingharora@gmail.com>
