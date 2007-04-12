Return-Path: <miltonm@bga.com>
Received: from ruth.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id 0D230DDF4C
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Apr 2007 01:44:33 +1000 (EST)
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <91308d2b933e4fe8a9618aef8748b878@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: 
Date: Thu, 12 Apr 2007 10:44:26 -0500
To: Matt Sealey <matt@genesi-usa.com>
Cc: ppcdev <linuxppc-dev@ozlabs.org>, Olaf Hering <olaf@aepfle.de>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Matt sealey wrote:

+               if (cb & 0x5) { /* if controller is configured for 
pci-native mode for both channels */

The above expression allows 1, 4, or 5 for the masked bits.  I'm 
guessing you
wanted to test that equal to either 5 or 0.

milton
