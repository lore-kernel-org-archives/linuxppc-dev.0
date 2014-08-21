Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 128831A007B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Aug 2014 17:34:54 +1000 (EST)
Message-ID: <1408606493.9307.7.camel@concordia>
Subject: Re: [PATCH 1/1] powerpc/jump_label: use HAVE_JUMP_LABEL?
From: Michael Ellerman <mpe@ellerman.id.au>
To: Zhouyi Zhou <zhouzhouyi@gmail.com>
Date: Thu, 21 Aug 2014 17:34:53 +1000
In-Reply-To: <1408588883-26783-1-git-send-email-yizhouzhou@ict.ac.cn>
References: <1408588883-26783-1-git-send-email-yizhouzhou@ict.ac.cn>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: aneesh.kumar@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
 jbaron@akamai.com, paulus@samba.org, jk@ozlabs.org,
 Zhouyi Zhou <yizhouzhou@ict.ac.cn>, paulmck@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2014-08-21 at 10:41 +0800, Zhouyi Zhou wrote:
> CONFIG_JUMP_LABEL doesn't ensure HAVE_JUMP_LABEL, if it
> is not the case use maintainers's own mutex to guard
> the modification of global values.
 
OK, so CONFIG_JUMP_LABEL says the user wants to use jump labels. But we also
need the toolchain to support it.

That is reflected in CC_HAVE_ASM_GOTO=y, and if both are set then
HAVE_JUMP_LABEL is set to true.

So this looks right to me.

cheers
