Return-Path: <GARCIAJ@3il.fr>
Received: from email.3il.fr (email.3il.fr [195.25.243.230])
	by ozlabs.org (Postfix) with ESMTP id 36F7567A64
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Mar 2005 00:28:23 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Tue, 15 Mar 2005 14:14:34 +0100
Message-ID: <D4FDDD1349B5AC46B68FC26AD8AF42D6226B11@exnet.3il.fr>
From: =?iso-8859-1?Q?Garcia_J=E9r=E9mie?= <GARCIAJ@3il.fr>
To: <linuxppc-dev@ozlabs.org>
Subject: Interrupts handling?
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi everybody,

Although I am a newbie in linux powerPC development, I am in charge of a =
related project.
The project is the following: I have to move a vXWorks application to a =
Linux (montavista) environnment with a 405EP processor. Unfotunately, my =
knowledges are very limited in BSP and with all the board specific =
functions (device drivers too...).
In my application, we assign IRQ only at its early beginning and we =
never change them after. Furthermore, this application uses an OS API =
layer in order to make it independant of the OS used. For exemple we =
encapsulate all the OS calls in this layer ; as that we theoretically =
only have to change this file to use another OS. To finish, we use POSIX =
pthreads to get an equivalent of vxWorks tasks.
Giving that, here are my questions:

 - is it possible to write a driver in this "file" (OS API Layer) or =
wherever I want?
 - do I need to use kernel modules even if I need to register my driver =
only one time?
 - is it possible for my application to register itself a driver or is =
it only a "kernel job"?
 - I have to map other vxWorks routines as "intEnable", "intDisable" =
which respectively enable/disable specified interrupt bit : may I use =
the linux equivalent "enable_irq" and "disqble_irq" and that wherever =
and whenever I want? (same question for the "request_irq" routine)=20

Tks a lot for your precious help cause over here I am really alone on =
that project and none use Linux!

J=E9r=E9mie
