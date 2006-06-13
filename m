Return-Path: <tie-fei.zang@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id E9DCC67B24
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Jun 2006 17:07:12 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	k5D7S7F1011021
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Jun 2006 00:28:07 -0700 (MST)
Received: from zch01exm40.ap.freescale.net (zch01exm40.ap.freescale.net
	[10.192.130.11])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id k5D779Ou007851
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Jun 2006 02:07:10 -0500 (CDT)
Message-ID: <9FCDBA58F226D911B202000BDBAD4673069C3F3C@zch01exm40.ap.freescale.net>
From: Zang Roy-r61911 <tie-fei.zang@freescale.com>
To: Paul Mackerras <paulus@samba.org>, Benjamin Herrenschmidt
	<benh@kernel.crashing.org>
Subject: [PATCH/2.6.17-rc6  0/4 v2]  powerpc: add mpc7448hpc2 (Taiga) boa
	rd support
Date: Tue, 13 Jun 2006 15:07:08 +0800
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, Alexandre.Bounine@tundra.com,
	Yang Xin-Xin-r48390 <Xin-Xin.Yang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


 Hi, 
  	This series of patch adds mpc7448hpc2 (taiga) board 
 support in arch/powerpc.	
 	Tsi108 chip of Tundra Semiconductor is also supported.
	The code has been revised according to the feedback.

 Roy Zang
