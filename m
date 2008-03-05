Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.183]) by ozlabs.org (Postfix) with ESMTP id A4450DDF39
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Mar 2008 22:32:02 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 0/11] celleb: patchset for 2.6.26
Date: Wed, 5 Mar 2008 12:31:47 +0100
References: <20080305.172000.-1300537299.kouish@swc.toshiba.co.jp>
In-Reply-To: <20080305.172000.-1300537299.kouish@swc.toshiba.co.jp>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200803051231.47888.arnd@arndb.de>
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
> This is a patchset for 2.6.26 which contains following changes:
>=20
> - cleanup =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 [PATCH 1/11]
> - move celleb files into platforms/cell/ =A0[PATCH 2/11]..[PATCH 7/11]
> - consolidate io-workarounds code =A0 =A0 =A0 =A0 [PATCH 8/11]..[PATCH 9/=
11]
> - add support for celleb PCI Express =A0 =A0 =A0[PATCH 10/11]
> - bug fix =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 [PATCH 11/11]
>=20
> Consolidating io-workarounds code changes the code to support
> CellBlade PCI. Please test it because I don't have any access to
> CellBlade.

Thanks for your patches, the first look I had at them left a very
good impression with your work. I'll send individual acks when
I'm confident enough with them to work on QS20.

	Arnd <><
