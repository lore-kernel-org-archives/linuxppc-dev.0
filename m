Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <004301c48145$a072a150$0301a8c0@chuck2>
From: "Mark Chambers" <markc@mail.com>
To: "Song Sam" <samlinuxppc@yahoo.com.cn>,
	"Li Yang-r58472" <LeoLi@freescale.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
References: <20040813082211.34144.qmail@web15610.mail.cnb.yahoo.com>
Subject: Re: JTAG debug mechanism
Date: Fri, 13 Aug 2004 10:55:44 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>
> But 8xx use BDM to debug CPU.So I wonder in which
> situation or chips should we use BDM and JATG and
> WHY??? For a embedded developer,he could more concern
> about this point than JATG implementation process,I
> guess.:-)
>

As I think you know, JTAG and Boundary Scan are industry standards intended
primarily for
board manufacturing purposes.  Boundary Scan allows you access to the pins
on BGAs and other impossible-
to-reach pins on dense boards.  The Motorola CPUs simply borrow these same
pins for debug purposes, but
the internal debug logic is not directly related to JTAG.

Motorola does not release all the information about the debug interface on
all their processors.  However, the
BDM interface is well documented, and there is an open source project called
bdm4gdb.sourceforge.net, which
has the raw material for you to learn all you could want to know about bdm.

Good luck,
Mark Chambers


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
