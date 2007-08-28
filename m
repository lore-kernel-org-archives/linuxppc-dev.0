Return-Path: <gerhard_pircher@gmx.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id E580ADDE26
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Aug 2007 04:58:33 +1000 (EST)
Content-Type: text/plain; charset="iso-8859-1"
Date: Tue, 28 Aug 2007 20:58:31 +0200
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
Message-ID: <20070828185831.303450@gmx.net>
MIME-Version: 1.0
Subject: ide/libata and powerpc arch/device tree
To: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

I'm currently/still trying to describe legacy ports and interrupts for a
VIA southbridge PCI IDE controller in a device tree. While the legacy ports
can be described in the PCI device node (as suggested to me by some
developers here in a previous discussion thread - by imitating the
Pegasos), this doesn't seem to be possible for the legacy IDE interrupts.
The general IDE driver code contains an interrupt quirk for the Pegasos,
whereas some PowerPC platforms still use the obsolete(?) IDE ppc_md
interface to define legacy ports and interrupts for an onboard IDE
controller.

Anyway, AFAIU libata will supersede the code under drivers/ide/, but
libata's VIA driver doesn't have the quirk for Pegasos. I would like
to know, if there are any plans to adapt the quirk for libata or if there
will be an OF interface for libata (to define the legacy IDE interrupts
in the device tree)?

Thanks!

regards,

Gerhard

BTW: Can somebody send me a dump of the Pegasos's device tree?
-- 
Psssst! Schon vom neuen GMX MultiMessenger gehört?
Der kanns mit allen: http://www.gmx.net/de/go/multimessenger
