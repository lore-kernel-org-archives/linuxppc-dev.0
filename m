Return-Path: <olaf@aepfle.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 507CFDDED4
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Mar 2007 05:37:51 +1100 (EST)
Date: Fri, 16 Mar 2007 19:37:48 +0100
From: Olaf Hering <olaf@aepfle.de>
To: Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
Subject: Re: Don't pass the stack pointer to zImage's start() function
Message-ID: <20070316183748.GA30637@aepfle.de>
References: <20070315042904.GE14061@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20070315042904.GE14061@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Mar 15, David Gibson wrote:

> At present, the zImage entry code passes a copy of the stack pointer
> to the start() function.  There's no real reason for this; the only
> thing start() does with it is print it out.  It appears to be a
> leftover debugging hack, so, this patch removes it.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

NACK.
It helps to determine the firmware memory layout.
