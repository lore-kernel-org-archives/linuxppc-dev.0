Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pa0-x241.google.com (mail-pa0-x241.google.com
 [IPv6:2607:f8b0:400e:c03::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rZ83H2rs9zDqjb
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jun 2016 12:40:43 +1000 (AEST)
Received: by mail-pa0-x241.google.com with SMTP id fg1so2589723pad.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jun 2016 19:40:43 -0700 (PDT)
Date: Wed, 22 Jun 2016 10:40:39 +0800
From: Simon Guo <wei.guo.simon@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Simon Guo <simonguo@linux.vnet.ibm.com>,
 Laurent Dufour <ldufour@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [RESEND][PATCH v2] powerpc: Export
 thread_struct.used_vr/used_vsr to user space
Message-ID: <20160622024039.GA4313@simonLocalRHEL7.x64>
References: <20160406070012.GA11647@simonLocalRHEL7.x64>
 <20160621063006.GA6367@simonLocalRHEL7.x64>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160621063006.GA6367@simonLocalRHEL7.x64>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 21, 2016 at 02:30:06PM +0800, Simon Guo wrote:
> Hi Michael,
> On Wed, Apr 06, 2016 at 03:00:12PM +0800, Simon Guo wrote:
> > These 2 fields track whether user process has used Altivec/VSX
> > registers or not. They are used by kernel to setup signal frame
> > on user stack correctly regarding vector part.
> > 
> > CRIU(Checkpoint and Restore In User space) builds signal frame
> > for restored process. It will need this export information to
> > setup signal frame correctly. And CRIU will need to restore these
> > 2 fields for the restored process.
> > 
> > Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>
> > Reviewed-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
> > ---
> 
> Just a kind reminder per our previous discussion.
> If possible, please help pull this in during 4.8 merge window. Some CRIU work items are pending for it.
> 
> Have a nice day.
> 
> Thanks,
> - Simon

+ linuxppc-dev list

Thanks,
- Simon (IBM LTC)
