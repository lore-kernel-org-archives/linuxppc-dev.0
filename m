Return-Path: <glikely@secretlab.ca>
Message-ID: <fa686aa40802232335k24729c0fm6f643d06cccaf087@mail.gmail.com>
Date: Sun, 24 Feb 2008 00:35:05 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Paul Mackerras" <paulus@samba.org>, linuxppc-dev@ozlabs.com,
	EricDuj <eric.dujardin@sagem.com>
Subject: Please pull linux-2.6-mpc52xx.git
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul, here is a bug fix that needs to go in for 2.6.25.

Thanks,
g.


The following changes since commit 42e6de0e6079f4a7ce6bd62340b1b14a1af314dc:
  Oliver Pinter (1):
        fix vmsas.c file permissions

are available in the git repository at:

  git://git.secretlab.ca/git/linux-2.6-mpc52xx.git for-2.6.25

Eric Dujardin (1):
      [POWERPC] Add export for mpc52xx_set_psc_clkdiv

 arch/powerpc/platforms/52xx/mpc52xx_common.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
