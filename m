Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: AgileDB and Abatron BDI 2000 ICE
Date: Fri, 11 Jul 2003 10:31:56 -0400
Message-ID: <8529B5552D4EAA4DAEDF49650C64B2B437128C@TARPON.mangrovesystems.com>
From: "Muhammad Sarwar" <msarwar@mangrovesystems.com>
To: "Steven Rothweiler" <Stevenr@raritan.com>,
	<linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


You are right about Abatron, it is definitely a good tool to have.

I recently evaluated Agile Software for 8260.

Few thoughts:

Main advantage of Agile is that it integrates Abatron's commands and
GDB debugging services.=20

Some features I liked were=20

Nice GUI for all BDI and GDB features at one place=20
Ability to move registers, structs etc to same watch window(by click
and drag)=20 Tools to automate some processes like loading of register
init file, playing back command script=20
Ability to set PC, other registers etc=20
Ability to use the same software for debugging of user applications=20

However there are some problems:=20

Program crashes frequently, they are offering new version of SW which
is supposed to be more stable. Problems in setting break points.
Problem in getting stack info display. Bug in display of struct
info=20

I think overall it brings good value for boot and kernel debugging.
Regards,

Muhammad Sarwar
Mangrove Systems Inc.


-----Original Message-----
From: Steven Rothweiler [mailto:Stevenr@raritan.com]
Sent: Friday, July 11, 2003 9:59 AM
To: linuxppc-embedded@lists.linuxppc.org
Subject: AgileDB and Abatron BDI 2000 ICE


Hi,

My organization is moving to Linux on MPC8270 (HW
being designed right now) and I was wondering what
everyone thought of the AgileDB-LX debugger, when
used with the Abatron BDI 2000 ICE.

We have neither product in house right now, and we
are trying to decide whether to evaluate them for
the development of our product.

I've seen a lot of good remarks about the Abatron
BDI 2000 ICE (that you shouldn't leave home without
it), but not much about AgileDB.  The product data
sheet looks impressive.  Any strong opinions out
there?

Also, we have an opening for an embedded PPC/Linux
engineer.  Where is the best place to post the ad?

Thanks.
--
Steven Rothweiler               Raritan Computer Inc
Embedded Engineer               400 Cottontail Lane
mailto:stevenr@raritan.com      Somerset, NJ   08873
732-764-8886 x1256


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
