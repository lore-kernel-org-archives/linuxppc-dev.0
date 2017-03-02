Return-Path: <bsingharora@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vYdV40F1QzDqMG
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Mar 2017 14:44:28 +1100 (AEDT)
Received: by mail-pg0-x243.google.com with SMTP id 1so7822281pgz.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Mar 2017 19:44:27 -0800 (PST)
From: Balbir Singh <bsingharora@gmail.com>
Date: Thu, 2 Mar 2017 14:44:19 +1100
To: Oliver O'Halloran <oohall@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/5] powerpc/smp: use cpu_to_chip_id() to find siblings
Message-ID: <20170302034419.GA7613@balbir.ozlabs.ibm.com>
References: <20170302004920.21948-1-oohall@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170302004920.21948-1-oohall@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Mar 02, 2017 at 11:49:16AM +1100, Oliver O'Halloran wrote:
> To determine which logical CPUs are on the same core the kernel uses the
> ibm,chipid property from the device tree node associated with that cpu.
> The lookup for this this information is currently open coded in both
> traverse_siblings() and traverse_siblings_chip_id(). This patch replaces
> these manual lookups with the existing cpu_to_chip_id() function.
> 
> Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
> ---

Looks like a nice cleanup

Balbir
