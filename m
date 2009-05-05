Return-Path: <glikely@secretlab.ca>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.28])
	by ozlabs.org (Postfix) with ESMTP id DFD93DDDEE
	for <linuxppc-dev@ozlabs.org>; Tue,  5 May 2009 15:16:46 +1000 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so2419868yxb.39
	for <linuxppc-dev@ozlabs.org>; Mon, 04 May 2009 22:16:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1241499317.10504.59.camel@pasglop>
References: <1241499317.10504.59.camel@pasglop>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 4 May 2009 23:16:29 -0600
Message-ID: <fa686aa40905042216n4d12fba7y21704fba1a201f59@mail.gmail.com>
Subject: Re: [git pull] Please pull powerpc.git merge branch
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	akpm <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hey Ben,

Can you please also pull in my merge branch?

http://ozlabs.org/pipermail/linuxppc-dev/2009-May/071626.html

Thanks,
g.

On Mon, May 4, 2009 at 10:55 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> Hi Linus !
>
> Here are a few things still for .30 for you to merge !
>
> Cheers,
> Ben.
>
> The following changes since commit 091438dd5668396328a3419abcbc6591159eb8=
d1:
> =A0Linus Torvalds (1):
> =A0 =A0 =A0 =A0Linux 2.6.30-rc4
>
> are available in the git repository at:
>
> =A0git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git merge
>
> Benjamin Herrenschmidt (1):
> =A0 =A0 =A0powerpc: Fix setting of oprofile cpu type
>
> Grant Likely (1):
> =A0 =A0 =A0powerpc: Update MPC5xxx and Xilinx Virtex maintainer entries
>
> Michael Wolf (1):
> =A0 =A0 =A0powerpc adjust oprofile_cpu_type version 3
>
> =A0MAINTAINERS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A04 ++--
> =A0arch/powerpc/kernel/cputable.c | =A0 15 ++++++++++-----
> =A02 files changed, 12 insertions(+), 7 deletions(-)
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at =A0http://www.tux.org/lkml/
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
