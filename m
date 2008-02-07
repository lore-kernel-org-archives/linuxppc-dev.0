Return-Path: <glikely@secretlab.ca>
Received: from ag-out-0708.google.com (ag-out-0708.google.com [72.14.246.246])
	by ozlabs.org (Postfix) with ESMTP id 2EFE3DDE3F
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Feb 2008 16:37:19 +1100 (EST)
Received: by ag-out-0708.google.com with SMTP id 31so7637182agc.0
	for <linuxppc-dev@ozlabs.org>; Wed, 06 Feb 2008 21:37:17 -0800 (PST)
Message-ID: <fa686aa40802062137k4668c038qe853bd7e566b4b3d@mail.gmail.com>
Date: Wed, 6 Feb 2008 22:37:17 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Olof Johansson" <olof@lixom.net>
Subject: Please pull linux-2.6-mpc52xx.git (again!)
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>,
	Rigby John-R61273 <jrigby@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 2/6/08, Grant Likely <grant.likely@secretlab.ca> wrote:
> On 2/6/08, Olof Johansson <olof@lixom.net> wrote:
> > mpc52xx_defconfig no longer builds for me, and the two latter of the
> > above patches are the ones that touch that file:
>
> Gah!  I caused some patch damage when I rebased the patches.  I'll
> send a fixup patch ASAP.

Paul, here's the fixup patch for my rebase screwup.  This solves the
mpc52xx compile failure.

The following changes since commit de0723dcca6e593a12a259798a54eb0e82628fb8:
  Nathan Fontenot (1):
        [POWERPC] Update default irq servers when boot cpu is removed

are available in the git repository at:

  git://git.secretlab.ca/git/linux-2.6-mpc52xx.git for-2.6.25

Grant Likely (1):
      [POWERPC] mpc52xx: fix compile error introduce when rebasing patch

 drivers/serial/mpc52xx_uart.c |   39 ++++++++++++++-------------------------
 1 files changed, 14 insertions(+), 25 deletions(-)

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
