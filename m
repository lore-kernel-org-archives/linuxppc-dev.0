Return-Path: <jwboyer@gmail.com>
Received: from mail-ww0-f45.google.com (mail-ww0-f45.google.com [74.125.82.45])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 23EACB7092
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Dec 2011 12:11:21 +1100 (EST)
Received: by wgbds13 with SMTP id ds13so10781384wgb.14
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Dec 2011 17:11:17 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20111221111349.c9d73384a0a2c89cd211239e@canb.auug.org.au>
References: <20111221111349.c9d73384a0a2c89cd211239e@canb.auug.org.au>
Date: Tue, 20 Dec 2011 20:11:17 -0500
Message-ID: <CA+5PVA7NhzxwxR5WGDmUQ432NehNnzRT+y05wve+FBXHyGaiwA@mail.gmail.com>
Subject: Re: linux-next: build warnings after merge of the 4xx tree
From: Josh Boyer <jwboyer@gmail.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
 Suzuki Poulose <suzuki@in.ibm.com>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Dec 20, 2011 at 7:13 PM, Stephen Rothwell <sfr@canb.auug.org.au> wr=
ote:
> Hi Josh,
>
> After merging the 4xx tree, today's linux-next build (powerpc ppc64_defco=
nfig)
> produced these warnings:
>
> WARN: Uncompressed kernel (size 0xe32858) overlaps the address of the wra=
pper()
> WARN: Fixing the link_address of wrapper to (0xf00000)
> WARN: Uncompressed kernel (size 0xd6c9e8) overlaps the address of the wra=
pper(0x400000)
> WARN: Fixing the link_address of wrapper to (0xe00000)
>
> Introduced by commit c55aef0e5bc6 ("powerpc/boot: Change the load address
> for the wrapper to fit the kernel"). =A0 Maybe "WARN" is not the best
> prefix for this. =A0To me it implies that something may go wrong and ther=
e
> is something to be fixed ... =A0If this is purely informational, then may=
be
> "INFO" would be better.

INFO indeed would be better.  I'll try and whip up a patch tomorrow
unless Suzie beats me to it.

Sorry about that.  I saw the WARN during my testing, but the commit
log explicitly mentioned it an brainwashed me into thinking it was OK.
 I blame holiday-itis.

josh
