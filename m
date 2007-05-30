Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 2A361DDF28
	for <linuxppc-dev@ozlabs.org>; Thu, 31 May 2007 00:28:04 +1000 (EST)
Date: Wed, 30 May 2007 09:33:26 -0500
To: "Sachin P. Sant" <sachinp@in.ibm.com>
Subject: Re: [Patch ] Kexec Kdump support for POWER6
Message-ID: <20070530143326.GA7549@lixom.net>
References: <465D099B.3020207@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <465D099B.3020207@in.ibm.com>
From: olof@lixom.net (Olof Johansson)
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, May 30, 2007 at 10:50:27AM +0530, Sachin P. Sant wrote:
> Paul, here is the final version of the patch with all review
> comments incorporated. 
> 
> Thanks
> -Sachin
> 
> 

> * On Power machines supporting VRMA, Kexec/Kdump does not work.
> * Hypervisor stores VRMA mapping used by the OS, in the hpte hash tables.
> * Make sure these hpte entries are left untouched.
> *
> * This patch also adds plpar_pte_read_raw() on the lines of
> * plpar_pte_remove_raw().
> 
> Signed-off-by : Sachin Sant <sachinp@in.ibm.com>
> Signed-off-by : Mohan Kumar M <mohan@in.ibm.com>

Acked-by: Olof Johansson <olof@lixom.net>


-Olof
