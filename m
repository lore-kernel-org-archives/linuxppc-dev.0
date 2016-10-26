Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t3mJP53b6zDt1q
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Oct 2016 21:21:09 +1100 (AEDT)
In-Reply-To: <1477041833-8302-1-git-send-email-vaibhav@linux.vnet.ibm.com>
To: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>,
 Christophe Lombard <clombard@linux.vnet.ibm.com>,
 Vaibhav Jain <vaibhav@linux.vnet.ibm.com>, stable@vger.kernel.org,
 Ian Munsie <imunsie@au1.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>, gkurz@linux.vnet.ibm.com
Subject: Re: [RESEND] cxl: Fix leaking pid refs in some error paths
Message-Id: <3t3mJP36R8z9t0J@ozlabs.org>
Date: Wed, 26 Oct 2016 21:21:08 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2016-21-10 at 09:23:53 UTC, Vaibhav Jain wrote:
> In some error paths in functions cxl_start_context and
> afu_ioctl_start_work pid references to the current & group-leader tasks
> can leak after they are taken. This patch fixes these error paths to
> release these pid references before exiting the error path.
> 
> Fixes: 7b8ad495("cxl: Fix DSI misses when the context owning task exits")
> Cc: stable@vger.kernel.org
> Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
> Reported-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
> Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
> Acked-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/a05b82d5149dfeef05254a11c3636a

cheers
