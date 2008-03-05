Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.179]) by ozlabs.org (Postfix) with ESMTP id 7C1BDDE069
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Mar 2008 22:43:24 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 9/11] celleb: consolidate io-workarounds code
Date: Wed, 5 Mar 2008 12:43:06 +0100
References: <20080305.173755.-1264110031.kouish@swc.toshiba.co.jp>
In-Reply-To: <20080305.173755.-1264110031.kouish@swc.toshiba.co.jp>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200803051243.06748.arnd@arndb.de>
Cc: paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 05 March 2008, Ishizaki Kou wrote:
> Now, we can use generic io-workarounds mechanism and the workaround
> code for spider-pci. This patch changes Celleb PCI code to use
> spider-pci code.
> 
> Signed-off-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>

Acked-by: Arnd Bergmann <arnd@arndb.de>

Removing code is always good, and this one obviously only impacts
celleb, so I'm confident it doesn't hurt on QS20.
