Return-Path: <frank.svendsboe@gmail.com>
Received: from mail-lb0-f179.google.com (mail-lb0-f179.google.com
 [209.85.217.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1E7C8B6FBA
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 May 2012 23:57:39 +1000 (EST)
Received: by lban1 with SMTP id n1so2112207lba.38
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 May 2012 06:57:36 -0700 (PDT)
Date: Fri, 18 May 2012 15:57:29 +0200
From: Frank Svendsboe <frank.svendsboe@gmail.com>
To: Artem Bityutskiy <dedekind1@gmail.com>
Subject: Re: [PATCH] mtd: Fix typo in Kconfig
Message-ID: <20120518135729.GA11703@gnubox>
References: <1337287389-28386-1-git-send-email-frank.svendsboe@gmail.com>
 <1337338834.2483.21.camel@sauron.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1337338834.2483.21.camel@sauron.fi.intel.com>
Cc: dbaryshkov@gmail.com, linuxppc-dev@lists.ozlabs.org,
 randy.dunlap@oracle.com, linux-mtd@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, May 18, 2012 at 02:00:34PM +0300, Artem Bityutskiy wrote:
> On Thu, 2012-05-17 at 22:43 +0200, Frank Svendsboe wrote:
> > MTD_OF_PARTS and the default setting is not working due to using 'Y'
> > instead of 'y', introduced in commit
> > d6137badeff1ef64b4e0092ec249ebdeaeb3ff37. This made our board, and
> > possibly other boards using DTS defined partitions and not having
> > CONFIG_MTD_OF_PARTS=y defined in the defconfig, fail to mount root
> > after v3.1.
> 
> The commit was released in v3.2, so it not v3.1 probably?
>

It was committed between 3.1 and 3.2-rc1. I said _after_ 3.1, so it is
not completely wrong either. Feel free to change to commit message, or
I can resend the patch if you want me to.

> > Signed-off-by: Frank Svendsboe <frank.svendsboe@gmail.com>
> 
> I've amended the subject to make it look scarier than just a fix of a
> typo, added a tag for the stable tree, and pushed to l2-mtd.git, thanks!
> 
> commit aa2465b2d5d44defb269ac66a2d2b6e6b8feb399
> Author: Frank Svendsboe <frank.svendsboe@gmail.com>
> Date:   Thu May 17 22:43:09 2012 +0200
> 
>     mtd: of_parts: fix breakage in Kconfig
>     
>     MTD_OF_PARTS and the default setting is not working due to using 'Y'
>     instead of 'y', introduced in commit
>     d6137badeff1ef64b4e0092ec249ebdeaeb3ff37. This made our board, and
>     possibly other boards using DTS defined partitions and not having
>     CONFIG_MTD_OF_PARTS=y defined in the defconfig, fail to mount root.
>     
>     Signed-off-by: Frank Svendsboe <frank.svendsboe@gmail.com>
>     Cc: stable@kernel.org [3.2+]
>     Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
> 

Great. Thanks!

-- 
Best regards,
Frank
