Return-Path: <UshaRani.Konudula@borland.com>
Received: from ussvs-mta4.amer.borl.net (outgoing5.borland.com [143.186.72.56])
	by ozlabs.org (Postfix) with ESMTP id 05A61679EF
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Apr 2006 20:19:19 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: Dynamically linking to pthread library
Date: Wed, 5 Apr 2006 18:02:40 +0800
Message-ID: <C9CDA704CB0EEA4DBE2EFC05AE11851C1C6A8A@SGSGS-EXCH01.apac.borl.net>
From: "Usha Rani Konudula" <UshaRani.Konudula@borland.com>
To: <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Do you need to explicitly specify -pthread option to g++ to make the
target library link with pthread dynamically. Otherwise does it
statically link to pthread library on ppc64 power5.

Kindly let me know.

Thanks
Usha.
