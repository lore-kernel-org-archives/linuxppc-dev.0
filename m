Return-Path: <BATV+37b1b20dd3b4402b9944+4602+infradead.org+acme@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2001:1868:205::9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qb2421tKmzDq5s
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Mar 2016 09:14:10 +1100 (AEDT)
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Andres Freund <andres@anarazel.de>, Anton Blanchard <anton@samba.org>,
 Carl Love <cel@us.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Michael Ellerman <mpe@ellerman.id.au>, Namhyung Kim <namhyung@kernel.org>,
 Peter Zijlstra <a.p.zijlstra@chello.nl>,
 Stephane Eranian <eranian@google.com>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [GIT PULL 0/2] perf/urgent fixes
Date: Wed, 30 Mar 2016 19:13:53 -0300
Message-Id: <1459376035-22929-1-git-send-email-acme@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ingo,

	Please consider pulling,

- Arnaldo

The following changes since commit f6343be96ebbae38a07e0878810f5bbc0c38cade:

  Merge tag 'perf-urgent-for-mingo-20160329' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/urgent (2016-03-30 12:31:03 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-urgent-for-mingo-20160330

for you to fetch changes up to 9f56c092b99b40ce3cf4c6d0134ff7e513c9f1a6:

  perf jit: genelf makes assumptions about endian (2016-03-30 18:12:06 -0300)

----------------------------------------------------------------
perf/urgent fixes:

- Fix determination of a callchain node's childlessness in
  the top/report TUI, which was preventing navigating some
  callchains, --stdio unnaffected (Andres Freund)

- Fix jitdump's genelf assumption that PowerPC is big endian
  only (Anton Blanchard)

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Andres Freund (1):
      perf hists: Fix determination of a callchain node's childlessness

Anton Blanchard (1):
      perf jit: genelf makes assumptions about endian

 tools/perf/ui/browsers/hists.c |  2 +-
 tools/perf/util/genelf.h       | 24 ++++++++++--------------
 2 files changed, 11 insertions(+), 15 deletions(-)
