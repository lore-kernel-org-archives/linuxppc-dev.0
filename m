Return-Path: <jwboyer@gmail.com>
Received: from mail-qc0-f179.google.com (mail-qc0-f179.google.com
 [209.85.216.179]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id AF931B6F77
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 May 2012 21:03:41 +1000 (EST)
Received: by qcha6 with SMTP id a6so4314206qch.38
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 May 2012 04:03:38 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1337661655.2779.167.camel@pasglop>
References: <1337651473.2779.140.camel@pasglop>
 <1337661655.2779.167.camel@pasglop>
Date: Tue, 22 May 2012 07:03:38 -0400
Message-ID: <CA+5PVA5g-XLdwaxSLAAuArcRMeZ43WR8pBZZkjdNd79Tr6EQ_w@mail.gmail.com>
Subject: Re: powerpc -next rebase WARNING
From: Josh Boyer <jwboyer@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Linux Kernel list <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, May 22, 2012 at 12:40 AM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Tue, 2012-05-22 at 11:51 +1000, Benjamin Herrenschmidt wrote:
>> Folks, bad news ... my fault.
>>
>> I accidentally forgot a --signoff on a git am command last week, meaning
>> that a pair of patches are in -next and not signed off by me.
>>
>> For various (legal) reasons that cannot go into Linus tree as-is, so I
>> have to rebase the tree to fix it.
>>
>> Sorry about that ...
>
> Note that the rebase only affects the top 3 commits, so if your
> tree is based on something older you're fine (Kumar, you seem to
> be ok, I haven't checked Josh).

Should be fine.  Even if not, all 4 of its users will manage to cope.

josh
