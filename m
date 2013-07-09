Return-Path: <B07421@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe004.messaging.microsoft.com [65.55.88.14])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 313022C0084
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jul 2013 02:53:53 +1000 (EST)
Date: Tue, 9 Jul 2013 11:53:45 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [RFC][PATCH 1/2] powerpc/booke: extend PTRACE_SINGLEBLOCK for
 BookE Branch Taken Debug
To: James Yang <James.Yang@freescale.com>
References: <1373062265-4267-1-git-send-email-James.Yang@freescale.com>
 <1373062265-4267-2-git-send-email-James.Yang@freescale.com>
In-Reply-To: <1373062265-4267-2-git-send-email-James.Yang@freescale.com>
 (from James.Yang@freescale.com on Fri Jul  5 17:11:04 2013)
Message-ID: <1373388825.8183.192@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/05/2013 05:11:04 PM, James Yang wrote:
> This patch makes available the unmodified BookE branch taken debug
> exception through PTRACE_SINGLEBLOCK if the ptrace() addr parameter is
> set to 2.

This is hacky -- if we must retain the existing PTRACE_SINGLEBLOCK =20
semantics (which aren't actually documented anywhere AFAICT -- if the =20
details are meant to be implementation-defined, then don't we have some =20
freedom here to actually do what the hardware does, especially if we =20
can't find existing users?), then perhaps a new PTRACE_WHATEVER should =20
be defined.

At the very least, magic numbers should be given symbolic names.

-Scott=
