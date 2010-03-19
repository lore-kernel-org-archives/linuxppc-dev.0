Return-Path: <temerkhanov@cifronik.ru>
Received: from cifronik.21th.com (cifronik.21th.com [62.16.86.116])
	by ozlabs.org (Postfix) with ESMTP id 09E01B7CB6
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 20 Mar 2010 02:46:43 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.cifronic.local (Postfix) with ESMTP id 3F16E8952F
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 19 Mar 2010 18:46:39 +0300 (MSK)
Received: from mail.cifronic.local ([127.0.0.1])
	by localhost (server.cifronic.local [127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id 9KQAxPbhr4oE for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 19 Mar 2010 18:46:38 +0300 (MSK)
Received: from satanklaus.localnet (satanklaus.cifronic.local [192.168.0.99])
	by mail.cifronic.local (Postfix) with ESMTPSA id A54CD8952D
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 19 Mar 2010 18:46:38 +0300 (MSK)
From: Sergey Temerkhanov <temerkhanov@cifronik.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] [RFC] Xilinx Virtex 4 FX Soft FPU support
Date: Fri, 19 Mar 2010 18:47:55 +0300
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <201003191847.55823.temerkhanov@cifronik.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch enables support for Xilinx Virtex 4 FX singe-float FPU.

Caveats: 
	- Hard-float binaries which rely on in-kernel math emulation will give wrong 	
	results since they expect 64-bit double-precision instead of 32-bit single-			
	precision numbers.

Regards, Sergey Temerkhanov
