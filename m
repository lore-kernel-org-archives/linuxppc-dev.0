Return-Path: <glikely@secretlab.ca>
Received: from mail-ob0-f179.google.com (mail-ob0-f179.google.com
 [209.85.214.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C6905B7003
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Apr 2012 09:21:48 +1000 (EST)
Received: by obbef5 with SMTP id ef5so8076270obb.38
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Apr 2012 16:21:45 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1334617419.25353.15.camel@pasglop>
References: <1334607198-18694-1-git-send-email-grant.likely@secretlab.ca>
 <CACxGe6u7EUYqyZ_8tC8PFRHwS+xq7u9+fCJk+UFbrtrV-YJFvQ@mail.gmail.com>
 <1334617419.25353.15.camel@pasglop>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 16 Apr 2012 17:21:25 -0600
Message-ID: <CACxGe6v3n7tjpMFCzyf+a0dvHm6X6KAcgm-VurVsUfugmKW5Sg@mail.gmail.com>
Subject: Re: [PATCH 1/2] powerpc/8xx: Fix NR_IRQ bugs and refactor 8xx
 interrupt controller
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Apr 16, 2012 at 5:03 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Mon, 2012-04-16 at 14:13 -0600, Grant Likely wrote:
>> Ben, I can take these two patches via my irqdomain tree if you prefer.
>
> Let me give them a test run first.

Yes of course.  I won't merge before they've been checked out.

g.
