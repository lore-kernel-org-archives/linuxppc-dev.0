Message-ID: <20040706164835.30925.qmail@web81609.mail.yahoo.com>
Date: Tue, 6 Jul 2004 09:48:35 -0700 (PDT)
From: Greg Goodwin <greg.goodwin@sbcglobal.net>
Subject: Frame Relay - Interphase 4538 - 2.4.20
To: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <40EABF09.30307@intracom.gr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I am presently developing Frame Relay support for the
Interphase 4538 and 5339F boards.

The intent is to run Frame Realy over T1/E1.

Originaly I tried to the FCC-2 channel in HDLC mode
but was unable to read packets correctly. I could
transmit a frame and it would receive on the other
side but the AB bit in the BD status was on and I
could not figure out how to fix the issue.There could
be an issue with the QUAD-FALC, maybe an issue for
single channel usage. QUAD-FALC appears on 1st channel
of ATM by design.

So, now I am programming the MCC units for HDLC mode.
So far I have not been able to get transmit interrupts
to  fly but I am just starting to really debug this
thing.

I am using the generic HDLC protocol layer for this
work.

The question is, has anyone done anything similiar to
what I am trying to accomplish here? Anything to help
get this thing rolling would be great.

All of the work I am doing is full GPL. So if support
for the Interphase 4538, 5339F are desired I do have
it working. In fact I have ATM running fine in AAL5
mode.Multiple phy support, 0-7 VPI, 0-255 VCI, 32 max
channels.CBR, UBR, UBRPLUS, VBR, VBR_RT and ABR
supported. The code is solid and has been running
solid since 1st of the year.

I have been busy with Frame Relay on the 4532 and
5339F  but I am also porting the Interphase 4532 OC3
board as well.

After Frame Relay is done I have IMA next.

Greg

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
