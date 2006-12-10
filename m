Return-Path: <paul@briny.ondioline.org>
Received: from jenny.ondioline.org (jenny.ondioline.org [66.220.1.122])
	by ozlabs.org (Postfix) with ESMTP id 13B0F67B9F
	for <linuxppc-dev@ozlabs.org>; Sun, 10 Dec 2006 18:20:22 +1100 (EST)
From: Paul Collins <paul@briny.ondioline.org>
To: linuxppc-dev@ozlabs.org
Subject: powerpc: "IRQ probe failed (0x0)" on powerbook
Date: Sun, 10 Dec 2006 19:45:48 +1300
Message-ID: <87lklg9rkz.fsf@briny.internal.ondioline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: paulus@samba.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On my PowerBook when booting Linus's tree as of commit af1713e0 I get
something like this:

  [blah blah]
  ide0: Found Apple UniNorth ATA-6 controller, bus ID 3, irq 0
  Probing IDE interface ide0...
  hda: HTS541080G9AT00, ATA DISK drive
  IRQ probe failed (0x0)
  IRQ probe failed (0x0)
  IRQ probe failed (0x0)
  IRQ probe failed (0x0)

And then of course it fails to mount root.  No such problem using a
kernel built from commit 97be852f of December 2nd.

-- 
Paul Collins
Wellington, New Zealand

Dag vijandelijk luchtschip de huismeester is dood
