Message-ID: <40769D14.3030801@imc-berlin.de>
Date: Fri, 09 Apr 2004 14:54:44 +0200
From: Steven Scholz <steven.scholz@imc-berlin.de>
MIME-Version: 1.0
To: Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: MPC8xx and wireless HERMES-II () ???
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi there,

I am trying to get a "proxim ORiNOCO PC Card" to work on my MPC8xx board
with PCMCIA CS.

Since it has a HERMES-II chipset I can't use the orinoco driver. So I went
for Agere's wl_lkm_718_release.tar.gz.

After inserting the card I get

	Wireless, HCF failure: "Command buffer size insufficient"

:-(

But funny enough I found the lines

/*******************************************************************/
/************************  Motorola Power PC 800 family  ***********/
/*******************************************************************/
/* known users: LH@I  */
#if defined I_MPC8XX
...

/*******************************************************************/
/************************  MPC860  *********************************/
/*******************************************************************/
/* known users: RR */

#if defined CPU
#if CPU == PPC860

in the include/hcf/hcfcfg.h. So of course now I wonder who might "LH@I" and
"RR" be and if they realy use this driver in an MPC8xx environment.

Any hints are mostly welcome !!!

Thansk a million!

--
Steven Scholz

imc Measurement & Control               imc Meﬂsysteme GmbH
Voltastr. 5                             Voltastr. 5
13355 Berlin                            13355 Berlin
Germany                                 Deutschland


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
