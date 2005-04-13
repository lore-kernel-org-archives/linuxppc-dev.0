Return-Path: <GARCIAJ@3il.fr>
Received: from email.3il.fr (email.3il.fr [195.25.243.230])
	by ozlabs.org (Postfix) with ESMTP id 75DCC67B65
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Apr 2005 20:00:39 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Wed, 13 Apr 2005 12:00:44 +0200
Message-ID: <D4FDDD1349B5AC46B68FC26AD8AF42D6226B21@exnet.3il.fr>
From: =?iso-8859-1?Q?Garcia_J=E9r=E9mie?= <GARCIAJ@3il.fr>
To: <linuxppc-dev@ozlabs.org>
Subject: Dynamic changing of Hz value
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi everybody,
I'm working on a project that needs the clock granularity changed from =
10ms to 5ms while running.
So as a kernel newbie, I understand that I have to deal with the HZ =
value. I read a lot of things on it through many forums and mailing =
lists but they always talk about it in a static way (how to fix a value =
different from 100) as with the Robert love's patch. What I would like =
to do is to code a routine that allows to modify the HZ value =
dynamically but the more I read about it and the more I begin to think =
that it is not possible.
Could someone tell me if, first of all, it is possible? If yes, what =
would be the process?

Note: I'm using a linux montavista pro 3.1 ( kernel 2.4.20 ) with a =
powerPC 405EP
