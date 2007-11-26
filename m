Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id D5DF7DDE3D
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Nov 2007 04:40:44 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [RFC/PATCHv4] powerpc: Move CPM command handling into the cpm
	drivers
Date: Mon, 26 Nov 2007 18:40:32 +0100
References: <474AFC6C.9020007@scram.de>
In-Reply-To: <474AFC6C.9020007@scram.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200711261840.32701.arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 26 November 2007, Jochen Friedrich wrote:
> This patch moves the CPM command handling into commproc.c
> for CPM1 and cpm2_common.c. This is yet another preparation
> to get rid of drivers accessing the CPM via the global cpmp.
> 
> Signed-off-by: Jochen Friedrich <jochen@scram.de>

Acked-by: Arnd Bergmann <arnd@arndb.de>
