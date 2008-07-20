Return-Path: <neko@genesi-usa.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.171])
	by ozlabs.org (Postfix) with ESMTP id 407F3DDE06
	for <linuxppc-dev@ozlabs.org>; Sun, 20 Jul 2008 20:03:22 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so164932ugf.0
	for <linuxppc-dev@ozlabs.org>; Sun, 20 Jul 2008 03:03:20 -0700 (PDT)
Message-ID: <48830D56.2080704@genesi-usa.com>
Date: Sun, 20 Jul 2008 11:03:02 +0100
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: ppc-dev <linuxppc-dev@ozlabs.org>
Subject: radeonfb, dedicate memory to something else
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: Matt Sealey <neko@genesi-usa.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi guys,

I know this isn't a PPC question, but since some of the RadeonFB developers
live here I thought best (and it's about a PPC platform).

Is there any way to hack up the RadeonFB driver - or anything related - to
reserve portions of the memory for a "fake" MTD or so, and still use the
Radeon as a graphics device? What I am talking about basically is turning
a 64MB Radeon card into a 32MB Radeon card, or a 128MB one into a 64MB
card..

I think this can be done by hacking a PCI fixup perhaps, for Efika only
in my case, whereby the memory ranges are fiddled.

Perhaps, a better solution is to use some kind of in-kernel subsystem to
"allocate" and return a 32MB segment of PCI memory (and put it in an
named rheap) but I assume other drivers can and will simply walk all
over it?

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations
