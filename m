Date: 29 May 2002 17:17:50 -0000
Message-ID: <20020529171750.3874.qmail@webmail14.rediffmail.com>
MIME-Version: 1.0
From: "navinb" <ppc4@rediffmail.com>
Reply-To: "navinb" <ppc4@rediffmail.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Problems in USB initialisation..
Content-type: text/plain;
	format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

I just want to get USB up in slave mode for 823/850 .

usb controller partially seems to be initialised.

A.
I am able to observe interrupts when it is attached to PC
also when the IDLE state of bus is changed ..relevant
bit is set in USBER(event register) to reflect the event.

1 ms timer interrupt and hence SOF generation is also o.k.

B.
what not working is when i connect to PC to test the slave mode
the dmesg o/p on my PC is always

hub.c: USB new device connect on bus1/1, assigned device number
105
usb-uhci.c: interrupt, status 2, frame# 1973
usb.c: USB device not accepting new address=105 (error=-110)

Interrupt, status 2 is defined as "interrupt due to error" in
usb-uhci.h.
I am not able to interpret whether this error is on pc side or
mpc823 side.

secondly never I got the bit set in USBER to indicate any frame
has been received though all those events are enabled.

may be all the frame would have been ignored..
I have tried to debug it by dumping all the rx and tx buffer ring
indexes and all other relevant registers but
still with no clue.

in the tcrc (traspernt crc ) and tptr(tx internal data pointer) i
always observe a byte pattern of "dead" and
"deaddead" respectively.

Best Regards,


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
