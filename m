Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17447.18487.819008.818925@cargo.ozlabs.ibm.com>
Date: Mon, 27 Mar 2006 13:04:39 +1100
From: Paul Mackerras <paulus@samba.org>
To: Haren Myneni <haren@us.ibm.com>
Subject: Re: [PATCH] kdump: clear and EOI IPI for kexec CPU
In-Reply-To: <44222FA0.90902@us.ibm.com>
References: <44222FA0.90902@us.ibm.com>
Cc: linuxppc-dev@ozlabs.org, ellerman@au1.ibm.com,
	Milton Miller <miltonm@bga.com>, Olaf Hering <olh@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Haren Myneni writes:

> Paul, Sorry, Please ignore the previous patch since it has one tab/space 
> issue. Tested this one and kdump-dma-fault-fix.patch on P5, P4 
> (non-lpar), JS21 and JS20.
> 
> Thanks
> Haren
> 
> Some times, the kexec CPU is not reponding to an IPI during kdump boot. 
> It is causing the system in xmon. Noticed on power-4 (non-lpar). This 
> patch clears and EOI IPI for kexec CPU as well before the kdump boot 
> started.

Sorry, that commit message is quite opaque to me.  Could you explain
in more detail what the problem is and how this fixes it?

Thanks,
Paul.
