Return-Path: <joakim.tjernlund@transmode.se>
Received: from tmnt04.transmode.se (147.175.241.83.in-addr.dgcsystems.net
	[83.241.175.147]) by ozlabs.org (Postfix) with ESMTP id 3D13867B52
	for <linuxppc-dev@ozlabs.org>; Sun,  1 Oct 2006 21:03:00 +1000 (EST)
From: "Joakim Tjernlund" <joakim.tjernlund@transmode.se>
To: "'Kim Phillips'" <kim.phillips@freescale.com>,
	<linuxppc-dev@ozlabs.org>
Subject: RE: [PATCH 2/2] Add support for MPC832x MDS evaluation board
Date: Sun, 1 Oct 2006 13:00:51 +0200
Message-ID: <027001c6e548$dbf65dc0$1267a8c0@Jocke>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <20060930215509.2989794a.kim.phillips@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: 
> linuxppc-dev-bounces+joakim.tjernlund=transmode.se@ozlabs.org 
> [mailto:linuxppc-dev-bounces+joakim.tjernlund=transmode.se@ozl
abs.org] On Behalf Of Kim Phillips
> Sent: den 1 oktober 2006 04:55
> To: linuxppc-dev@ozlabs.org
> Subject: [PATCH 2/2] Add support for MPC832x MDS evaluation board
> 
> Add support for MPC832x MDS evaluation board.
> 
> This patch depends on the 8360+QE patches by Leo Li.

Thank you, I have been struggling with adapting Leo's earlier 8360 patches
on top of 2.6.17 but could not get UCC2 and UCC4(only UCC3 worked) to work
as network i/f's.
Hopefully I will get some time next week to try this out on our MPC832x MDS evaluation board and/or our custom board.

I hope you will be able to address the of_device conversation problem
you mentioned until then.

 Jocke
