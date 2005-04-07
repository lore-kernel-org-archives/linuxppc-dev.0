Return-Path: <panto@intracom.gr>
Received: from mailserv.intranet.gr (mailserv.intranet.GR [146.124.14.106])
	by ozlabs.org (Postfix) with ESMTP id E808567AC5
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Apr 2005 20:38:26 +1000 (EST)
Received: from mailserv.intranet.gr (localhost [127.0.0.1])
	by mailserv.intranet.gr (8.13.1/8.13.1) with ESMTP id j37AYhCm016520
	for <linuxppc-dev@ozlabs.org>; Thu, 7 Apr 2005 13:34:43 +0300 (EEST)
Message-ID: <4255092A.5080300@intracom.gr>
Date: Thu, 07 Apr 2005 13:19:22 +0300
From: Pantelis Antoniou <panto@intracom.gr>
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Garcia_J=E9r=E9mie?= <GARCIAJ@3il.fr>
References: <D4FDDD1349B5AC46B68FC26AD8AF42D6226B1B@exnet.3il.fr>
In-Reply-To: <D4FDDD1349B5AC46B68FC26AD8AF42D6226B1B@exnet.3il.fr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
Subject: Re: Interrupt disabling design
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Garcia Jérémie wrote:
> Hi everybody, 
> I'm trying to emulate a VxWorks-designed application under a linux montavista environment.
> In this application I have critical portion of code which need the interrupts disabled as below:

[snip]
> 
> Is it possible to do that? Cause If I do a "cli()" call, I disable interrupts --> so, will the "sti()" call work?
> If yes, it allows me to make my own system call to use them from the user space but I'm not really sure...
> 
> Tks a lot for your help 
> _______________________________________________

Although it might be possible to something like that with root permissions,
  I'd recommend against it.

If you want to run code with disabled interrupts, move that code in a kernel
module and disable/enable interrupts in the kernel
(still bad but acceptable).

IMHO of course.

Regards

Pantelis
