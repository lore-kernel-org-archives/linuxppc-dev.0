Return-Path: <GARCIAJ@3il.fr>
Received: from email.3il.fr (email.3il.fr [195.25.243.230])
	by ozlabs.org (Postfix) with ESMTP id 124AA67A33
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Mar 2005 19:59:07 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Thu, 31 Mar 2005 11:59:08 +0200
Message-ID: <D4FDDD1349B5AC46B68FC26AD8AF42D6226B17@exnet.3il.fr>
From: =?iso-8859-1?Q?Garcia_J=E9r=E9mie?= <GARCIAJ@3il.fr>
To: <linuxppc-dev@ozlabs.org>
Subject: How to read/write in flash memories (MTD)?
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

L&G,
Although I'm a newbie in linux kernel development, I'm in charge of =
adapting a Montavista LSP to fit our hardware. In our platform, we use 2 =
AMD flash memories (AM29LV) in which one we would like to process =
read/write operations. So I'm looking for a way to do that. I saw that =
at compilation time, there is MTD item which seems to be created for =
that. But I guess activate that will not be enough to reach my =
objective.
Indeed, we are developping an application (in the user-space) which will =
initiate operation on the 2 flash memories. So, how can I access them =
from my application?
Please help me cause I'm getting lost in the linux sources....

NOTE: i'm using a powerPC 405EP

J=E9r=E9mie
