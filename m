Content-Type: text/plain;
  charset="iso-8859-1"
From: Paul Ruhland <pruhland@rochester.rr.com>
To: "Steve Clarke" <steve.clarke@overturenetworks.com>
Subject: Re: PCMCIA on MBX860
Date: Sun, 4 Feb 2001 14:22:55 -0500
Cc: <linuxppc-embedded@lists.linuxppc.org>
References: <HCELKHHHIOJIDLBGAKBCKECFCAAA.steve.clarke@overturenetworks.com> <01020413495000.00647@kanga>
In-Reply-To: <01020413495000.00647@kanga>
MIME-Version: 1.0
Message-Id: <01020414225501.00647@kanga>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Sunday 04 February 2001 13:49, Paul Ruhland wrote:

> Steve,
>
> I will send you the changes for the MBX860 in another reply tomorrow (
> 20010205 ).  All of that code is presently on my work machine.
>

I managed to find an a patch for the pcmcia-cs-3.1.22 I made for the mbx. I
only have code for the 'voltage_set' function in this patch.  You should be
able to use this as a starting point for changes to pcmcia-cs-3.1.24...this
was done hastily and the hardware_enable, hardware_disable should probably be
implemented and the voltage_set could use some work.  I believe this got it
up and running...I was able to use a 3Com LAN card ( 3c589_cs driver ).
Also, this patch doesn't include the irq stuff I mention in my previous reply.

I then abandoned the MBX in favor of an STK/TQM850L board from Denx Software
Engineering/TQ Components ( http://www.denx.de ) for various reasons.

For embedded mpc8xx development, I strongly recommend the STK/TQM boards and
PPCBOOT bootloader/monitor..outstanding hardware, software, support, and
documentation.

-------------------------------
Paul Ruhland
Micrwave Data Systems Inc.
175 Science Parkway
Rochester, NY 14620
TEL: +1.716.242.8372
EMAIL: pruhland@microwavedata.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
