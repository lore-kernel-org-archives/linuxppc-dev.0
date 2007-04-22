Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 508BBDDEEB
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Apr 2007 09:15:10 +1000 (EST)
Date: Sun, 22 Apr 2007 18:34:11 -0500
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: save trap number in bad_stack
Message-ID: <20070422233411.GA28479@lixom.net>
References: <20070416062347.GA20196@lixom.net>
	<1177024678.7286.23.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1177024678.7286.23.camel@localhost.localdomain>
From: olof@lixom.net (Olof Johansson)
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Apr 20, 2007 at 09:17:58AM +1000, Benjamin Herrenschmidt wrote:
> Can you put it elsewhere in the PACA (around less frequently used
> bits) ? This is a pretty hot area of the PACA...

Good point, I didn't think much about layout when I added it. There's
actually room right before if it's reduced in size (which is easy to do).
See patch posted separately.


-Olof
