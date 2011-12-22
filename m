Return-Path: <Kyle.D.Moffett@boeing.com>
From: Kyle Moffett <Kyle.D.Moffett@boeing.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 0/6] powerpc/mpic: More general cleanups and fixups
Date: Thu, 22 Dec 2011 15:19:08 -0500
Message-Id: <1324585155-13453-1-git-send-email-Kyle.D.Moffett@boeing.com>
Cc: devicetree-discuss@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello all,

With the following series of patches, most new MPC85xx platforms should
be able to get away with just this code (assuming updated dtb):

  struct mpic *mpic = mpic_alloc(NULL, 0, 0, 0, "OpenPIC");
  mpic_init(mpic);

Several of the hard-coded flags can now be provided as properties in
the device-tree, and hopefully future tweaks can be hooked in the same
way.

Cheers,
Kyle Moffett
