Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3C695395.7DEC4A71@opensource.se>
Date: Tue, 12 Feb 2002 18:40:37 +0100
From: Magnus Damm <damm@opensource.se>
MIME-Version: 1.0
To: "David Marqvar (DAM)" <DAM@tt.dk>
Cc: "Embedded Linux PPC List (E-mail)" <linuxppc-embedded@lists.linuxppc.org>,
	"Laurits Lassen Petersen (LLP)" <LLP@tt.dk>
Subject: Re: Kernel 2.4.4
References: <E8F83D6D2A6AD3118E0300902786A20502371417@NTEX>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> My next step is to find a simple bootloader..

Try Miniboot!
It is almost as simple as a bootloader can be.

http://opensource.se/projects/

Miniboot now supports 4 different boards,
all with mpc8xx processors.

A new version will be released soon...

And, you may want to boot PPCBoot from Miniboot.
This will make it possible to update PPCBoot
without any BDM.

Cheers /

Magnus

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
