Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rtKfr1fVFzDqHC
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Jul 2016 20:49:08 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Cc: clombard@linux.vnet.ibm.com, vaibhav@linux.vnet.ibm.com,
 fbarrat@linux.vnet.ibm.com, ukrishn@linux.vnet.ibm.com, imunsie@au1.ibm.com,
 felix@linux.vnet.ibm.com
Subject: Re: [PATCH] cxl: add option to enable -DDEBUG
In-Reply-To: <1468829857-821-1-git-send-email-andrew.donnellan@au1.ibm.com>
References: <1468829857-821-1-git-send-email-andrew.donnellan@au1.ibm.com>
Date: Mon, 18 Jul 2016 20:49:01 +1000
Message-ID: <877fcjb4rm.fsf@@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Andrew Donnellan <andrew.donnellan@au1.ibm.com> writes:

> Developers working on AFUs and AFU drivers often find it useful to see the
> pr_devel() and dev_dbg() messages from cxl. Give them an easy way to enable
> -DDEBUG by adding a Kconfig option, CONFIG_CXL_DEBUG.

Another option is to use DYNAMIC_DEBUG. If you turn that on the
dev_dbg()'s can be enabled at runtime, and you could en masse or
selectively convert the pr_devel()s to pr_debug() to get the same
result.

cheers
