Message-ID: <397D8178.F6521A0F@francetelecom.fr>
Date: Tue, 25 Jul 2000 14:00:56 +0200
From: FASSINO Jean-Philippe <jeanphilippe.fassino@francetelecom.fr>
MIME-Version: 1.0
To: Donald Cowart <dcowart@acld.lib.fl.us>
CC: "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
Subject: Re: RTAS on PowerMac Newworld
References: <Pine.LNX.4.20.0007250756370.31668-100000@bookworm.acld.lib.fl.us>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Donald Cowart wrote:

> Newbie question, what is RTAS?

It is the Run-Time Abstraction Services which provide functions
to insulate operating systems from having to know about and manipulating
a number devices. It is a interface between hardware and software.
For example, RTAS provide functions for reading and writing PCI configuration,
shutdown, reboot, get time, managing power, ... of the CHRP computer.

JP


--
--------------------------------------------------------------------------
 Jean-Philippe FASSINO              France Telecom R&D : DTL/ASR
 Tel : 04 76 76 45 52
 mailto:jeanphilippe.fassino@francetelecom.fr
--------------------------------------------------------------------------


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
