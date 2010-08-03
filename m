Return-Path: <paulus@ozlabs.org>
Date: Tue, 3 Aug 2010 11:04:12 +1000
From: Paul Mackerras <paulus@samba.org>
To: Ingo Molnar <mingo@elte.hu>
Subject: Please pull my perf.git master branch
Message-ID: <20100803010412.GA28995@brick.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Peter Zijlstra <peterz@infradead.org>, Scott Wood <scottwood@freescale.com>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ingo,

Please do a pull from my perf.git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/paulus/perf.git master

to get two commits.  They only affect the driver for the PMU on the
Freescale embedded PowerPC processors.  One is from Peter Z. and has
been around for some time.  The other fixes a bug introduced by a
patch from Peter Z. that I sent upstream recently.

Thanks,
Paul.

Peter Zijlstra (1):
      perf, powerpc: Convert the FSL driver to use local64_t

Scott Wood (1):
      perf, powerpc: fsl_emb: Restore setting perf_sample_data.period

 arch/powerpc/kernel/perf_event_fsl_emb.c |   29 +++++++++++++++--------------
 1 files changed, 15 insertions(+), 14 deletions(-)
