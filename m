Return-Path: <glikely@secretlab.ca>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.231])
	by ozlabs.org (Postfix) with ESMTP id 19448DDE00
	for <linuxppc-dev@ozlabs.org>; Sun, 21 Dec 2008 19:06:21 +1100 (EST)
Received: by rv-out-0506.google.com with SMTP id f6so2289593rvb.9
	for <linuxppc-dev@ozlabs.org>; Sun, 21 Dec 2008 00:06:18 -0800 (PST)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 0/4] powerpc/mpc5200: Add support for ATA DMA
To: linuxppc-dev@ozlabs.org, hans.lehmann@ritter-elektronik.de,
	matt@genesi-usa.com, olaf@aepfle.de
Date: Sun, 21 Dec 2008 01:06:14 -0700
Message-ID: <20081221080213.29029.7646.stgit@localhost.localdomain>
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

Hey everyone; here is the latest version of the patches to add ATA DMA
support for the MPC5200.  I'm pretty confident that these patches won't
break anything and by default DMA support is turned off.  Users wanting
to test ATA DMA should add the 'libata.force=udma2' parameter to the
kernel command line.

Since there are just minor changes from the last iteration and a couple
of changes have been broken out into separate patches, I'm pushing this
series out to my -next tree for Paul to pick up.

Cheers,
g.

--
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
