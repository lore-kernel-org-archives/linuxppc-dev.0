Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f223.google.com (mail-gx0-f223.google.com
	[209.85.217.223]) by ozlabs.org (Postfix) with ESMTP id B88FBB6F01
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Jan 2010 16:14:48 +1100 (EST)
Received: by gxk23 with SMTP id 23so19044121gxk.2
	for <linuxppc-dev@ozlabs.org>; Tue, 05 Jan 2010 21:14:47 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 5 Jan 2010 22:14:27 -0700
Message-ID: <fa686aa41001052114w7fbd45fydf03c61d19b2cfe8@mail.gmail.com>
Subject: [git pull] 5200 defconfigs and bootwrapper fix
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Peter Tyser <ptyser@xes-inc.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ben,

Here's the 5200 defconfig updates and a fix for build errors when
U-Boot's 'mkimage' tool isn't in $PATH.

g.

The following changes since commit 74d2e4f8d79ae0c4b6ec027958d5b18058662eea:
  Linus Torvalds (1):
        Linux 2.6.33-rc3

are available in the git repository at:

  git://git.secretlab.ca/git/linux-2.6 merge

Grant Likely (1):
      powerpc/5200: update defconfigs

Peter Tyser (1):
      powerpc: Use scripts/mkuboot.sh instead of 'mkimage'

 arch/powerpc/boot/wrapper                     |    7 +-
 arch/powerpc/configs/52xx/cm5200_defconfig    |   75 ++++++++++++++---
 arch/powerpc/configs/52xx/lite5200b_defconfig |   90 +++++++++++++++++-----
 arch/powerpc/configs/52xx/motionpro_defconfig |   79 +++++++++++++++---
 arch/powerpc/configs/52xx/pcm030_defconfig    |   83 +++++++++++++++-----
 arch/powerpc/configs/52xx/tqm5200_defconfig   |   79 +++++++++++++++---
 arch/powerpc/configs/mpc5200_defconfig        |  106 ++++++++++++++++++++-----
 7 files changed, 418 insertions(+), 101 deletions(-)

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
