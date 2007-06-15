Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: for-2.6.23 branch in powerpc.git created 
In-reply-to: <18034.6787.951861.623265@cargo.ozlabs.ibm.com> 
References: <18034.6787.951861.623265@cargo.ozlabs.ibm.com>
Date: Fri, 15 Jun 2007 15:40:51 +1000
Message-ID: <12413.1181886051@neuling.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> I have created a for-2.6.23 branch in the powerpc.git repository
> (git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git)
> where I have started queueing up patches to go in once the 2.6.23
> merge window opens.  For now at least it's the same as the master
> branch.
> 
> The patches I put in are listed below.  If you have a patch that
> should go in but isn't listed, remind me about it.

Paul,

Can you take these two:

  "do firmware feature fixups after features are initialised"
  http://patchwork.ozlabs.org/linuxppc/patch?id=11617

  "fix stolen time for SMT without LPAR"
  http://patchwork.ozlabs.org/linuxppc/patch?id=11616

Thanks,
Mikey
