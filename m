Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 152481A00B0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Mar 2015 10:08:57 +1100 (AEDT)
Date: Fri, 20 Mar 2015 10:08:48 +1100
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] powerpc: Export __spin_yield
Message-ID: <20150319230848.GB31148@iris.ozlabs.ibm.com>
References: <54EE5989.7010800@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <54EE5989.7010800@linux.vnet.ibm.com>
Cc: "Suresh E. Warrier" <warrier@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Feb 25, 2015 at 05:23:53PM -0600, Suresh E. Warrier wrote:
> Export __spin_yield so that the arch_spin_unlock() function can
> be invoked from a module. This will be required for modules where
> we want to take a lock that is also is acquired in hypervisor
> real mode. Because we want to avoid running any lockdep code
> (which may not be safe in real mode), this lock needs to be 
> an arch_spinlock_t instead of a normal spinlock.
> 
> Signed-off-by: Suresh Warrier <warrier@linux.vnet.ibm.com>

Acked-by: Paul Mackerras <paulus@samba.org>
