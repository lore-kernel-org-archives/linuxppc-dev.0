Return-Path: <jwboyer@gmail.com>
Received: from mail-gx0-f21.google.com (mail-gx0-f21.google.com
	[209.85.217.21]) by ozlabs.org (Postfix) with ESMTP id 04BFFDDF4F
	for <linuxppc-dev@ozlabs.org>; Fri,  5 Sep 2008 23:16:21 +1000 (EST)
Received: by gxk14 with SMTP id 14so6735521gxk.9
	for <linuxppc-dev@ozlabs.org>; Fri, 05 Sep 2008 06:16:20 -0700 (PDT)
Date: Fri, 5 Sep 2008 09:15:34 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: Updated 4xx next branch
Message-ID: <20080905131534.GA4511@yoda.jdub.homelinux.org>
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

The following patches have been pushed to the next branch of the 4xx tree.
As usual, I'll let them sit there for a bit before asking Paul to pull.  If
I've missed any patches, please let me know.  We have lots of time before the
.28 merge window opens, so don't worry too much.

josh

Ilya Yanok (1):
      powerpc/4xx: Necessary fixes to PCI for 4GB RAM size

Josh Boyer (9):
      powerpc/44x: Add PowerPC 44x simple platform support
      powerpc/44x: Migrate Bamboo support to ppc44x_simple
      powerpc/44x: Migrate Canyonlands support to ppc44x_simple
      powerpc/44x: Migrate Katmai support to ppc44x_simple
      powerpc/44x: Migrate Rainier support to ppc44x_simple
      powerpc/44x: Migrate Sequoia support to ppc44x_simple
      powerpc/44x: Migrate Taishan support to ppc44x_simple
      powerpc/44x: Add explicit support for AMCC Glacier
      powerpc/44x: Add explicit Yosemite support

Tirumala R Marri (1):
      powerpc/44x: AMCC PPC460GT/EX PCI-E de-emphasis adjustment fix
