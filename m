Return-Path: <gerhard_stamer@gmx.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.21])
	by ozlabs.org (Postfix) with SMTP id 05628689C5
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jan 2006 08:07:14 +1100 (EST)
Date: Wed, 11 Jan 2006 22:00:32 +0100 (MET)
From: "Gerhard Pircher" <gerhard_stamer@gmx.net>
To: linuxppc-dev@ozlabs.org,debian-powerpc@lists.debian.org
MIME-Version: 1.0
Message-ID: <6063.1137013232@www88.gmx.net>
Content-Type: text/plain; charset="us-ascii"
Subject: AGPGART driver for ArticiaS - ioremap() problem
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

David Bentam and I are trying to get a AGPGART driver working for the
AmigaOne and the Pegasos1. The driver detects the aperture size of the
ArticiaS AGP bridge, but fails at the ioremap() function in the generic GATT
table create function. Does the PowerPC platform behaves differently for the
mapping of address location for AGP operation than the x86 platform? Is it
possible to use a mask to relocate the AGP address space to a specific
location?

regards,

Gerhard Pircher

-- 
Telefonieren Sie schon oder sparen Sie noch?
NEU: GMX Phone_Flat http://www.gmx.net/de/go/telefonie
