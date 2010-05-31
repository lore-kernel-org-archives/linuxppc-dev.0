Return-Path: <agraf@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 41C32B7D57
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Jun 2010 06:00:55 +1000 (EST)
Subject: Re: [PATCH] KVM: PPC: elide struct thread_struct instances from stack
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <m26323onam.fsf@igel.home>
Date: Mon, 31 May 2010 22:00:48 +0200
Message-Id: <B79B7AA8-2BDD-4857-A6E3-72C7D7B3FA47@suse.de>
References: <m26323onam.fsf@igel.home>
To: Andreas Schwab <schwab@linux-m68k.org>
Cc: linuxppc-dev@ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 31.05.2010, at 21:59, Andreas Schwab wrote:

> Instead of instantiating a whole thread_struct on the stack use only the
> required parts of it.
> 
> Signed-off-by: Andreas Schwab <schwab@linux-m68k.org>
> Tested-by: Alexander Graf <agraf@suse.de>

Avi or Marcelo, please pull this in through kvm.git.

Signed-off-by: Alexander Graf <agraf@suse.de>


Alex
