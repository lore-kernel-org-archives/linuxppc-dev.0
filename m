Return-Path: <jwboyer@gmail.com>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.28])
	by ozlabs.org (Postfix) with ESMTP id 9E670475F8
	for <linuxppc-dev@ozlabs.org>; Fri,  5 Sep 2008 01:02:21 +1000 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so1746641yxg.39
	for <linuxppc-dev@ozlabs.org>; Thu, 04 Sep 2008 08:02:19 -0700 (PDT)
Date: Thu, 4 Sep 2008 11:01:25 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, netdev@vger.kernel.org
Subject: [PATCH 0/3] Various fixes and additions for PowerPC 405EZ
Message-ID: <20080904150125.GA2479@yoda.jdub.homelinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: Josh Boyer <jwboyer@gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The following patch series adds things needed to support the
PowerPC 405EZ SoC.  I'm mostly sending these out now for review
and feedback, since I'll need to get these fixed up before I can
send out the Acadia board port patches.

The first patch should be good as-is.  The second two might need a
bit of rework, depending on various things.

josh

Josh Boyer (3):
  ibm_newemac: Allow the "no flow control" EMAC feature to work
  ibm_newemac: Introduce mal_has_feature
  ibm_newemac: MAL support for PowerPC 405EZ

 drivers/net/ibm_newemac/Kconfig |   12 +++++
 drivers/net/ibm_newemac/core.c  |    2 +
 drivers/net/ibm_newemac/core.h  |    3 +
 drivers/net/ibm_newemac/mal.c   |   98 +++++++++++++++++++++++++++++++--------
 drivers/net/ibm_newemac/mal.h   |   37 +++++++++++++++
 5 files changed, 132 insertions(+), 20 deletions(-)
