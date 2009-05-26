Return-Path: <dan.j.williams@gmail.com>
Received: from mail-qy0-f196.google.com (mail-qy0-f196.google.com
	[209.85.221.196]) by ozlabs.org (Postfix) with ESMTP id C290EDDFCC
	for <linuxppc-dev@ozlabs.org>; Wed, 27 May 2009 09:59:26 +1000 (EST)
Received: by qyk34 with SMTP id 34so6998367qyk.17
	for <linuxppc-dev@ozlabs.org>; Tue, 26 May 2009 16:59:25 -0700 (PDT)
MIME-Version: 1.0
Sender: dan.j.williams@gmail.com
In-Reply-To: <2a27d3730905220347s59dbd152kc69c8399693ae307@mail.gmail.com>
References: <2a27d3730905220347s59dbd152kc69c8399693ae307@mail.gmail.com>
Date: Tue, 26 May 2009 16:59:23 -0700
Message-ID: <e9c3a7c20905261659v5d785df3w646efd4cbba2e6dd@mail.gmail.com>
Subject: Re: [GIT PULL] fsldma driver fixes
From: Dan Williams <dan.j.williams@intel.com>
To: Li Yang <leoli@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev Development <linuxppc-dev@ozlabs.org>,
	Ira Snyder <iws@ovro.caltech.edu>, lkml <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, May 22, 2009 at 3:47 AM, Li Yang <leoli@freescale.com> wrote:
> Hi Dan,
>
> Here are fixes for Freescale DMA engine driver.
>
> Thanks,
> - Leo
>
>
> The following changes since commit 5805977e63a36ad56594a623f3bd2bebcb7db2=
33:
> =A0Linus Torvalds (1):
> =A0 =A0 =A0 =A0Merge branch 'for-linus' of git://git.kernel.org/.../jbarn=
es/drm-2.6
>
> are available in the git repository at:
>
> =A0git://git.kernel.org/pub/scm/linux/kernel/git/leo/fsl-soc.git fsldma
>
> Ira Snyder (4):
> =A0 =A0 =A0fsldma: fix "DMA halt timeout!" errors
> =A0 =A0 =A0fsldma: fix infinite loop on multi-descriptor DMA chain comple=
tion
> =A0 =A0 =A0fsldma: snooping is not enabled for last entry in descriptor c=
hain
> =A0 =A0 =A0fsldma: fix memory leak on error path in fsl_dma_prep_memcpy()
>
> Li Yang (1):
> =A0 =A0 =A0fsldma: update mailling list address in MAINTAINERS
>
> Roel Kluin (1):
> =A0 =A0 =A0fsldma: fix check on potential fdev->chan[] overflow
>

Pulled, thanks.  These all look like 2.6.30 candidates, right?  I'll
send these upstream in the next few days as I have not heard back from
Kumar on taking fsldma patches through his tree [1].

Thanks,
Dan

[1]: http://marc.info/?l=3Dlinux-kernel&m=3D124225089507475&w=3D2
