Return-Path: <curt@cumulusnetworks.com>
Received: from mail-pa0-x229.google.com (mail-pa0-x229.google.com
 [IPv6:2607:f8b0:400e:c03::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 041891A0338
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2015 05:46:46 +1100 (AEDT)
Received: by pacej9 with SMTP id ej9so64973221pac.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Nov 2015 10:46:44 -0800 (PST)
From: Curt Brune <curt@cumulusnetworks.com>
To: galak@codeaurora.org, ijc+devicetree@hellion.org.uk, mark.rutland@arm.com,
 pawel.moll@arm.com, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, robh+dt@kernel.org
Cc: linuxppc-dev@lists.ozlabs.org,
	devicetree@vger.kernel.org
Subject: [RFC 0/1] PowerPC legacy serial console / device tree
Date: Wed, 25 Nov 2015 10:46:48 -0800
Message-Id: <1448477209-22340-1-git-send-email-curt@cumulusnetworks.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Proposing to use the 'cell-index' property to map device tree serial
nodes to legacy serial port number.  For example this allows the
device to explicity specify which serial device to use for ttyS0.

The basic idea is outlined in the following patch.

If this approach seems reasonable I would follow up with additional
patches for Documentation/devicetree/ bindings and
Documentation/powerpc/.

Curt Brune (1):
  powerpc: legacy serial port use device tree cell-index property

 arch/powerpc/kernel/legacy_serial.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

-- 
1.9.1
