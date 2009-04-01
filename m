Return-Path: <glikely@secretlab.ca>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.228])
	by ozlabs.org (Postfix) with ESMTP id A38C8DE09B
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Apr 2009 17:16:53 +1100 (EST)
Received: by rv-out-0506.google.com with SMTP id g37so3535847rvb.1
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Mar 2009 23:16:52 -0700 (PDT)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 0/3] Series short description
To: netdev@vger.kernel.org, linuxppc-dev@ozlabs.org,
	David Miller <davem@davemloft.net>
Date: Wed, 01 Apr 2009 00:16:46 -0600
Message-ID: <20090401060117.8641.32252.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi David,

Here are the fec_mpc52xx patches which should be picked up for 2.6.29.
Patch #1 fixes a dma related BUG_ON() discovered after the merge window
opened.  #2 & #3 were original a single patch posted prior to the merge
window, but not having a s-o-b line from the original author held them up.
In the end I rewrote it from scratch as two patches just so I can get
them merged.  #2 makes the driver use net_device_ops, and #3 fixes a NULL
dereference.

I've tested these patches on several MPC5200 platforms.

 drivers/net/fec_mpc52xx.c |   77 +++++++++++++++++++++++++-------------------
 1 files changed, 44 insertions(+), 33 deletions(-)

Cheers,
g.

--
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
