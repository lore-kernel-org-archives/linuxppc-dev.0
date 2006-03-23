Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 7C35767A3B
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Mar 2006 16:39:52 +1100 (EST)
Date: Wed, 22 Mar 2006 23:38:54 -0600
To: Haren Myneni <haren@us.ibm.com>
Subject: Re: [PATCH] kdump: Fix for machine checkstop on DMA fault
Message-ID: <20060323053854.GA17693@pb15.lixom.net>
References: <44222462.2030103@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <44222462.2030103@us.ibm.com>
From: Olof Johansson <olof@lixom.net>
Cc: linuxppc-dev@ozlabs.org, ellerman@au1.ibm.com,
	Paul Mackerras <paulus@samba.org>,
	Milton Miller <miltonm@bga.com>, Olaf Hering <olh@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Mar 22, 2006 at 08:30:26PM -0800, Haren Myneni wrote:
> Paul, If you are OK with this fix, please send it upstream.
> 
> Thanks
> Haren
> 
> - Some machines checkstop on dma protection fault for ongoing DMA left 
> in the first kernel. Since, we do not shutdown devices before the kdump 
> boot, let them continue DMA to old kernel space.

How is this solved for regular kexec, doesn't the same problem exist
there?


-Olof
