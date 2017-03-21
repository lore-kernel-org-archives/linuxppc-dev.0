Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vnW3h6H7HzDq95
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Mar 2017 22:36:16 +1100 (AEDT)
In-Reply-To: <1488879162-20596-1-git-send-email-me@tobin.cc>
To: tcharding <me@tobin.cc>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 "Tobin C. Harding" <me@tobin.cc>
Subject: Re: [RESEND] powerpc/pseries: move struct hcall_stats to c file
Message-Id: <3vnW3h4lJPz9s8B@ozlabs.org>
Date: Tue, 21 Mar 2017 22:36:16 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-03-07 at 09:32:42 UTC, tcharding wrote:
> struct hcall_stats is only used in hvCall_inst.c.
> 
> Move struct hcall_stats to hvCall_inst.c
> 
> Signed-off-by: Tobin C. Harding <me@tobin.cc>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/017614a5d6c09ec9e0dc3fd46a5018

cheers
