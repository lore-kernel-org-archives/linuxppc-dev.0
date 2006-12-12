Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id A9D1767BE8
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Dec 2006 07:03:45 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 8/15] Supporting PCI bus and base of I/O
Date: Tue, 12 Dec 2006 21:03:41 +0100
References: <200612120338.kBC3c08S020556@toshiba.co.jp>
In-Reply-To: <200612120338.kBC3c08S020556@toshiba.co.jp>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200612122103.41597.arnd@arndb.de>
Cc: paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 12 December 2006 04:37, Ishizaki Kou wrote:
> This patch includes support for pci buses, base of Celleb specific
> devices, and etc. It works on of_platform bus.
> 
> Signed-off-by: Kou Ishizaki <kou.ishizaki.co.jp>

The code looks good to me, I guess it could go in, except that
I really don't like the concept of faking a PCI bus device when
it's not actually there. I guess the EPCI part of this is
not controversial, so it would be good if you can split that
out into a separate patch that we can merge first.

	Arnd <><
