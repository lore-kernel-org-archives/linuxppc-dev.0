Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id CB516B6FA9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Feb 2012 11:29:49 +1100 (EST)
Message-ID: <1329438578.2892.34.camel@pasglop>
Subject: 5020 SATA fix
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Xulei <B33228@freescale.com>
Date: Fri, 17 Feb 2012 11:29:38 +1100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Lei !

In your SDK kernel I see this commit:

92c0ce1e599e788ffc0908739db9bd5e0dbdad69
sata_fsl: Add the workaround for SATA-A005 erratum on P2040/P3041/P5020

Without this commit, SATA doesn't work on the p5020ds board that FSL
just sent me. I see this was committed in June last year, any reason why
this is not upstream yet ?

Any objection to me just sending it upstream ?

Cheers,
Ben.
