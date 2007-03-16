Return-Path: <olaf@aepfle.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id E728ADDED5
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Mar 2007 07:04:52 +1100 (EST)
Date: Fri, 16 Mar 2007 21:04:52 +0100
From: Olaf Hering <olaf@aepfle.de>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: Don't pass the stack pointer to zImage's start() function
Message-ID: <20070316200452.GA31793@aepfle.de>
References: <20070315042904.GE14061@localhost.localdomain>
	<20070316183748.GA30637@aepfle.de>
	<1174073217.16140.10.camel@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1174073217.16140.10.camel@zod.rchland.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Mar 16, Josh Boyer wrote:

> How, why is that useful, and where is that ever used?

prom_init runs with the stack passed from the firmware (unless that
changed in since 2.6.13). Its better to know where the stack is when
looking at early boot bugreports.
