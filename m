Return-Path: <glikely@secretlab.ca>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.28])
	by ozlabs.org (Postfix) with ESMTP id 58754DDF05
	for <linuxppc-dev@ozlabs.org>; Sat,  2 May 2009 23:38:22 +1000 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so1621252yxb.39
	for <linuxppc-dev@ozlabs.org>; Sat, 02 May 2009 06:38:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <fa686aa40904282058l64fbcc7cp5ea3521951bd6b9c@mail.gmail.com>
References: <fa686aa40904282058l64fbcc7cp5ea3521951bd6b9c@mail.gmail.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Sat, 2 May 2009 07:38:04 -0600
Message-ID: <fa686aa40905020638paea4930nee01b9b9a81926b9@mail.gmail.com>
Subject: Re: Please pull merge branch
To: Paul Mackerras <paulus@samba.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Paul/Ben,

Here is an updated pull request which adds a fix to the bootwrapper
Makefile clean-files list.  Please pull 'merge' branch of
git://git.secretlab.ca/git/linux-2.6

Thanks,
g.

The following changes since commit 091438dd5668396328a3419abcbc6591159eb8d1=
:
  Linus Torvalds (1):
        Linux 2.6.30-rc4

are available in the git repository at:

  git://git.secretlab.ca/git/linux-2.6 merge

Grant Likely (3):
      powerpc: Update MPC5xxx and Xilinx Virtex maintainer entries
      powerpc/virtex: Add uImage to the default images list
      powerpc/boot: add simpleImage.* to clean-files list

John Linn (1):
      powerpc/virtex: Fix duplicate level irq events.

 MAINTAINERS                        |    4 +-
 arch/powerpc/boot/Makefile         |    2 +-
 arch/powerpc/platforms/40x/Kconfig |    1 +
 arch/powerpc/platforms/44x/Kconfig |    1 +
 arch/powerpc/sysdev/xilinx_intc.c  |  117 ++++++++++++++++++++++++++++++++=
---
 5 files changed, 112 insertions(+), 13 deletions(-)


On Tue, Apr 28, 2009 at 9:58 PM, Grant Likely <grant.likely@secretlab.ca> w=
rote:
> Hi Paul/Ben,
>
> Here is a bug fix, a minor tweak and a tidy to merge for 2.6.30.
> Please pull 'merge' branch of git://git.secretlab.ca/git/linux-2.6
>
> Thanks,
> g.
>
> The following changes since commit 56a50adda49b2020156616c4eb15353e0f9ad7=
de:
> =A0Linus Torvalds (1):
> =A0 =A0 =A0 =A0Merge branch 'drm-intel-next' of
> git://git.kernel.org/.../anholt/drm-intel
>
> are available in the git repository at:
>
> =A0git://git.secretlab.ca/git/linux-2.6 merge
>
> Grant Likely (2):
> =A0 =A0 =A0powerpc: Update MPC5xxx and Xilinx Virtex maintainer entries
> =A0 =A0 =A0powerpc/virtex: Add uImage to the default images list
>
> John Linn (1):
> =A0 =A0 =A0powerpc/virtex: Fix duplicate level irq events.
>
> =A0MAINTAINERS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A04 =
+-
> =A0arch/powerpc/platforms/40x/Kconfig | =A0 =A01 +
> =A0arch/powerpc/platforms/44x/Kconfig | =A0 =A01 +
> =A0arch/powerpc/sysdev/xilinx_intc.c =A0| =A0117 ++++++++++++++++++++++++=
++++++++---
> =A04 files changed, 111 insertions(+), 12 deletions(-)
>
>
> --
> Grant Likely, B.Sc., P.Eng.
> Secret Lab Technologies Ltd.
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
