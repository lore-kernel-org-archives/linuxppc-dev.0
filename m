Message-Id: <200007011839.UAA29375@denx.local.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: (Manually) relocate PPC code?
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Date: Sat, 01 Jul 2000 20:39:14 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I need to write some C code on PPC which must stay relocatable, resp.
I must relocate it myself (all of code and data etc.). I'm using GNU
tools.

This is for a standalone application, _NOT_ running under Linux.

Where can I find documentation about things like the format of the
GOT etc., or ideally existing _simple_ (read: small) example code?

All hints, pointers, ideas appreciated - TIA!

Wolfgang

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Little known fact about Middle Earth:   The Hobbits had a very sophi-
sticated computer network!   It was a Tolkien Ring...

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
