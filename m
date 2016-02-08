Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 15CA31A0291
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Feb 2016 17:01:20 +1100 (AEDT)
Date: Mon, 8 Feb 2016 17:01:16 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: mpe@ellerman.id.au, benh@kernel.crashing.org,
 linuxppc-dev@lists.ozlabs.org, aik@ozlabs.ru, thuth@redhat.com,
 lvivier@redhat.com
Subject: Re: [RFCv2 9/9] pseries: Automatically resize HPT for memory hot
 add/remove
Message-ID: <20160208060116.GI30807@oak.ozlabs.ibm.com>
References: <1454045043-25545-1-git-send-email-david@gibson.dropbear.id.au>
 <1454045043-25545-10-git-send-email-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1454045043-25545-10-git-send-email-david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jan 29, 2016 at 04:24:03PM +1100, David Gibson wrote:
> We've now implemented code in the pseries platform to use the new PAPR
> interface to allow resizing the hash page table (HPT) at runtime.
> 
> This patch uses that interface to automatically attempt to resize the HPT
> when memory is hot added or removed.  This tries to always keep the HPT at
> a reasonable size for our current memory size.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Reviewed-by: Paul Mackerras <paulus@samba.org>
