Return-Path: <jwboyer@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.177])
	by ozlabs.org (Postfix) with ESMTP id 6C634DDF8D
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Apr 2008 08:51:02 +1000 (EST)
Received: by py-out-1112.google.com with SMTP id z59so233157pyg.27
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Apr 2008 15:50:55 -0700 (PDT)
Subject: Re: patches for 2.6.26
From: Josh Boyer <jwboyer@gmail.com>
To: David Miller <davem@davemloft.net>
In-Reply-To: <20080410.151616.204291886.davem@davemloft.net>
References: <D9A4BB4A-970C-4E9E-9174-BA8C0191CCA2@kernel.crashing.org>
	<200804101720.36975.laurentp@cse-semaphore.com>
	<20080410.151616.204291886.davem@davemloft.net>
Content-Type: text/plain
Date: Thu, 10 Apr 2008 17:50:52 -0500
Message-Id: <1207867852.3996.39.camel@vader.jdub.homelinux.org>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2008-04-10 at 15:16 -0700, David Miller wrote:
> From: Laurent Pinchart <laurentp@cse-semaphore.com>
> Date: Thu, 10 Apr 2008 17:20:36 +0200
> 
> > On Thursday 10 April 2008 16:21, Kumar Gala wrote:
> > > Guy's
> > > 
> > > if you have work you want in 2.6.26 related to Freescale PPC's let me  
> > > know.  Ideally you can provide links to the patches in
> > > http://patchwork.ozlabs.org/linuxppc/ 
> > 
> > Could you please add this one ?
> > 
> > fs_enet: Don't call NAPI functions when NAPI is not used.
> > http://patchwork.ozlabs.org/linuxppc/patch?id=17055
> 
> I kindly request that PPC folks send networking driver patches through
> the normal channels so that the networking experts on netdev and
> people like Jeff Garzik can review such changes.

Normally we do.  But we appreciate the reminder.  Particularly since it
reminded me that I need to chase Jeff down about the ibm_newemac patches
that were sent a while ago.

josh
