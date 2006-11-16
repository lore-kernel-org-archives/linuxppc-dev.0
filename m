Return-Path: <gerhard_pircher@gmx.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 60EF867BCE
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Nov 2006 19:48:02 +1100 (EST)
Content-Type: text/plain; charset="iso-8859-1"
Date: Thu, 16 Nov 2006 09:48:00 +0100
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
Message-ID: <20061116084800.132070@gmx.net>
MIME-Version: 1.0
Subject: [RFC] Workaround for G4 CPU data corruption bug
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

I need to fix the CPU bug described here:
http://ozlabs.org/pipermail/linuxppc-dev/2004-August/017440.html

The bug is worked around in Linux (since a long time) by enabling coherency (M bit) for all memory mappings. Unfortunately my AmigaOne crashes badly with this workaround (the system simply stops after setting up the PCI host controller). I'm afraid I don't know about any snoop control settings within the northbridge.

Thus the only workaround I can think of would be to disable the L2 cache prefetch logic. But would this workaround be accepted in the Linux source tree (only for one architecture) or does anybody know another workaround?

Thanks in advance!

regards,

Gerhard

-- 
"Ein Herz für Kinder" - Ihre Spende hilft! Aktion: www.deutschlandsegelt.de
Unser Dankeschön: Ihr Name auf dem Segel der 1. deutschen America's Cup-Yacht!
