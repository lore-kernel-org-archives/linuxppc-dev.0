Return-Path: <glikely@secretlab.ca>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.182])
	by ozlabs.org (Postfix) with ESMTP id E0078DDE04
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Nov 2008 12:08:41 +1100 (EST)
Received: by wa-out-1112.google.com with SMTP id m33so331847wag.9
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Nov 2008 17:08:40 -0800 (PST)
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 0/2] Addition of MWDMA/UDMA modes to MPC5200 ATA driver
To: plasm@roo.me.uk, matt@genesi-usa.com, hans.lehmann@ritter-elektronik.de,
	linux-ide@vger.kernel.ort, jgarzik@pobox.com, linuxppc-dev@ozlabs.org
Date: Wed, 12 Nov 2008 18:08:35 -0700
Message-ID: <20081113010438.464.23602.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: Grant Likely <glikely@secretlab.ca>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi all,

This is Tim's series for adding UDMA/MWDMA support to the Freescale
MPC5200 ATA device driver.  Tested on Genesi's Efika board.

Jeff, if it is okay by you, I'm going to push this through my mpc5200
powerpc tree (after addressing any comments of course) since it only
affects the MPC5200 PowerPC SoC.

g.

--
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
