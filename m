Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.171]) by ozlabs.org (Postfix) with ESMTP id 918DADDDFA
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Feb 2008 13:51:46 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] Fix legacy serial search for opb bus ports
Date: Thu, 7 Feb 2008 03:51:35 +0100
References: <9efb8c0e313840ccb1bdf918406cdc812ec5de94.1202212897.git.michael@ellerman.id.au>
In-Reply-To: <9efb8c0e313840ccb1bdf918406cdc812ec5de94.1202212897.git.michael@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200802070351.35411.arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 05 February 2008, Michael Ellerman wrote:
> The fix is to add two entries to the of_device_id table, one that looks
> for type = "opb" and the other compatible = "ibm,opb".
> 
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>

Acked-by: Arnd Bergmann <arnd@arndb.de>
