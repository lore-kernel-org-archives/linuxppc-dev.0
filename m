Return-Path: <jeff@theptrgroup.com>
Received: from mail.theptrgroup.com (mail.theptrgroup.com [209.183.211.17])
	by ozlabs.org (Postfix) with ESMTP id 06B6967B17
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Jun 2005 01:32:02 +1000 (EST)
From: Jeff Angielski <jeff@theptrgroup.com>
To: Garcia =?ISO-8859-1?Q?J=E9r=E9mie?= <GARCIAJ@3il.fr>
In-Reply-To: <D4FDDD1349B5AC46B68FC26AD8AF42D6226B31@exnet.3il.fr>
References: <D4FDDD1349B5AC46B68FC26AD8AF42D6226B31@exnet.3il.fr>
Content-Type: text/plain; charset=utf-8
Date: Wed, 08 Jun 2005 11:26:56 -0400
Message-Id: <1118244417.8540.24.camel@nighteyes.site>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Subject: Re: PPC arch and spinlocks
Reply-To: jeff@theptrgroup.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2005-06-08 at 16:29 +0200, Garcia Jérémie wrote:
> Hi everybody, I need your help one more time.
> I'm new to kernel device driver (linux newbie) and I'd like to control concurrent access
> to our hardware resources. (I'm working on a ppc405EP platform uniprocessor)

You might find this guide useful:

http://www.kernelnewbies.org/documents/kdoc/kernel-locking/lklockingguide.html



Jeff Angielski
The PTR Group
