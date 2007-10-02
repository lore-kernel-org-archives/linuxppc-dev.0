Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id DC66ADDF11
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Oct 2007 18:19:03 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
Subject: Re: [PATCH 7/7] Celleb: update for PCI
Date: Tue, 2 Oct 2007 10:18:47 +0200
References: <20071002.170439.-1300534196.kouish@swc.toshiba.co.jp>
In-Reply-To: <20071002.170439.-1300534196.kouish@swc.toshiba.co.jp>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200710021018.48329.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 02 October 2007, Ishizaki Kou wrote:
> Though I agree it's better to make code common, I hope to keep them
> separate for now. Because I'm now developing PCI Express support and
> it also uses io-workaround mechanism. I'll try to make them common in
> this work.

Ok, fair enough. Let's use your current version for 2.6.24 and then
work on a new version that handles both PCI and PCIe correctly
on both platforms. I'm certainly interested in getting the PCIe
workarounds running on QS20 as well.

	Arnd <><
