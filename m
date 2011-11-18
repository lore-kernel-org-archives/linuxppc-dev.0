Return-Path: <MAILER-DAEMON>
Received: from WA2EHSNDR001.bigfish.com (smtp-cpk.frontbridge.com
 [204.231.192.41]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id DF48AB7258
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Nov 2011 21:12:26 +1100 (EST)
Received: from mail110-tx2 (localhost.localdomain [127.0.0.1])	by
 mail110-tx2-R.bigfish.com (Postfix) with ESMTP id 27F9C600679	for
 <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Nov 2011 10:12:03 +0000 (UTC)
Received: from TX2EHSMHS041.bigfish.com (unknown [10.9.14.254])	by
 mail110-tx2.bigfish.com (Postfix) with ESMTP id 0AFAC105804F	for
 <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Nov 2011 10:12:03 +0000 (UTC)
Date: Fri, 18 Nov 2011 18:12:07 +0800
From: Zhao Chenhui <chenhui.zhao@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v2 1/7] powerpc/85xx: re-enable timebase sync disabled by
 KEXEC patch
Message-ID: <20111118101207.GA14411@localhost.localdomain>
References: <1321437344-19253-1-git-send-email-chenhui.zhao@freescale.com>
 <4EC40406.1030408@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <4EC40406.1030408@freescale.com>
Sender: <zch@localhost.localdomain>
Cc: linuxppc-dev@lists.ozlabs.org
Reply-To: zch@localhost.localdomain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Nov 16, 2011 at 12:42:14PM -0600, Scott Wood wrote:
> On 11/16/2011 03:55 AM, Zhao Chenhui wrote:
> > From: Li Yang <leoli@freescale.com>
> > 
> > The timebase sync is not only necessary when using KEXEC. It should also
> > be used by normal boot up and cpu hotplug. Remove the ifdef added by
> > the KEXEC patch.
> 
> Again, no it should not be used by normal boot up (whether KEXEC support
> is enabled or not).  We should only do timebase sync when we actually
> need to (when we've actually just reset a core), and we should do it the
> way U-Boot does rather than with smp-tbsync.c.
> 
> -Scott

OK. I'll do it the way U-Boot does.
Thanks.

-chenhui
