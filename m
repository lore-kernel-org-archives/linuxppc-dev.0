Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BF5E61A0190
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Feb 2016 16:47:18 +1100 (AEDT)
Date: Mon, 8 Feb 2016 13:46:53 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: mpe@ellerman.id.au, benh@kernel.crashing.org,
 linuxppc-dev@lists.ozlabs.org, aik@ozlabs.ru, thuth@redhat.com,
 lvivier@redhat.com
Subject: Re: [RFCv2 1/9] memblock: Don't mark memblock_phys_mem_size() as
 __init
Message-ID: <20160208024653.GA30807@oak.ozlabs.ibm.com>
References: <1454045043-25545-1-git-send-email-david@gibson.dropbear.id.au>
 <1454045043-25545-2-git-send-email-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1454045043-25545-2-git-send-email-david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jan 29, 2016 at 04:23:55PM +1100, David Gibson wrote:
> At the moment memblock_phys_mem_size() is marked as __init, and so is
> discarded after boot.  This is different from most of the memblock
> functions which are marked __init_memblock, and are only discarded after
> boot if memory hotplug is not configured.
> 
> To allow for upcoming code which will need memblock_phys_mem_size() in the
> hotplug path, change it from __init to __init_memblock.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Reviewed-by: Paul Mackerras <paulus@samba.org>
