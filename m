Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e36.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E57582C00A5
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Oct 2012 04:12:17 +1000 (EST)
Received: from /spool/local
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Tue, 2 Oct 2012 12:12:13 -0600
Message-ID: <506B2E63.5090900@linux.vnet.ibm.com>
Date: Tue, 02 Oct 2012 13:11:47 -0500
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: devicetree-discuss@lists.ozlabs.org, cbe-oss-dev@lists.ozlabs.org,
 LKML <linux-kernel@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0/5] Move some OF functionality from pseries to generic OF code
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This set of patches moves some OF code that has been living
in the pseries tree over to the generic OF code base. The
functionality being migrated over is something that, I believe,
should live in the generic code base. The specific functionality
being migrated to generic OF code is;

o Updating the device tree in /proc when adding/removing a node.
o Adding a notification chain for adding/removing nodes and
  properties of the device tree.
o Re-naming the base OF code prom_* routines to of_* to better go
  with the naming used for OF code.

-Nathan 
