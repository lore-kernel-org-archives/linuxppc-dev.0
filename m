Return-Path: <glikely@secretlab.ca>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.170])
	by ozlabs.org (Postfix) with ESMTP id 2C6AFDE5BE
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Jul 2008 00:37:50 +1000 (EST)
Received: by wf-out-1314.google.com with SMTP id 24so416836wfg.15
	for <linuxppc-dev@ozlabs.org>; Wed, 02 Jul 2008 07:37:50 -0700 (PDT)
Date: Wed, 2 Jul 2008 08:37:40 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: linuxppc-dev@ozlabs.org, paulus@samba.org
Subject: Please pull linux-2.6-mpc52xx.git for 2.6.26
Message-ID: <20080702143740.GA22023@secretlab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: Grant Likely <glikely@secretlab.ca>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Paul,

Here is one more last minute 2.6.26 bug fix.

The following changes since commit 1702b52092e9a6d05398d3f9581ddc050ef00d06:
  Linus Torvalds (1):
        Merge git://git.kernel.org/.../mchehab/v4l-dvb

are available in the git repository at:

  git://git.secretlab.ca/git/linux-2.6-mpc52xx.git for-2.6.26

Tim Yamin (1):
      powerpc/mpc5200: Fix lite5200b suspend/resume

 arch/powerpc/platforms/52xx/lite5200_pm.c |   14 +++++++++++++-
 1 files changed, 13 insertions(+), 1 deletions(-)
