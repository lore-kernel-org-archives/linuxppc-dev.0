Return-Path: <wg@grandegger.com>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 30141DE041
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Jun 2008 19:01:47 +1000 (EST)
Message-ID: <4847AB78.8000405@grandegger.com>
Date: Thu, 05 Jun 2008 11:01:44 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v2 0/4] [POWERPC] 85xx: Add suport for TQM8548 and some TQM85xx
	fixes
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello,

it follows version 2 of patches adding support for the TQM8548 modules
from TQ Components (http://www.tqc.de) and furthermore fixing some
issues with other TQM85xx modules.

They are already based on Kumar's powerpc Linux tree (linux-2.6-galak).

The NAND support requires the patch with the subject
"[PATCH v2] [NAND] driver extension to support NAND on TQM85xx modules"
posted to this list a few minutes ago.

Wolfgang.
