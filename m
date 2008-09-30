Return-Path: <jwboyer@gmail.com>
Received: from mail-gx0-f21.google.com (mail-gx0-f21.google.com
	[209.85.217.21]) by ozlabs.org (Postfix) with ESMTP id 08AFADDF3D
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Oct 2008 05:41:50 +1000 (EST)
Received: by gxk14 with SMTP id 14so11868323gxk.9
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Sep 2008 12:41:49 -0700 (PDT)
Date: Tue, 30 Sep 2008 15:40:36 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: Patches added to 4xx 'next' branch
Message-ID: <20080930194036.GA9313@yoda.jdub.homelinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: Josh Boyer <jwboyer@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi All,

The following patches have been added to the 4xx 'next' branch

Josh Boyer (3):
      ibm_newemac: Allow the "no flow control" EMAC feature to work
      ibm_newemac: Introduce mal_has_feature
      ibm_newemac: MAL support for PowerPC 405EZ

Matthias Fuchs (1):
      ppc4xx: Allow 4xx PCI bridge to be disabled via device tree

Victor Gallardo (1):
      ibm_newemac: Add support for GPCS, SGMII and M88E1112 PHY

As usual, they will sit there for a few days and then I'll ask Paul
(or maybe Ben) to pull into the overall powerpc.git tree.

josh
