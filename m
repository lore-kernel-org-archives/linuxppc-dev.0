Message-ID: <67505026E29DD311A9AA00508B7315F33B735B@EXCHANGE>
From: Mike Flynn <mflynn@enerdyne.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: kmem_grow: Called nonatomically from int - size-32?
Date: Tue, 25 Jul 2000 12:27:25 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


We have been hacking away on a TI  16C554 quad UART driver based on
serial.c. The driver supports the TI chip on our motherboard which hosts an
Embedded Planet CLLF with an MOT 860T processor. We have all four ports
working with interrupts, but we are seeing this message several times before
the system hangs: "kmem_grow: Called nonatomically from int - size-32." It
is issued from linux/mm/slab.c and obviously has something to do with shared
memory. Does anyone have insight as to what we are (or are not doing) to
upset slab.c?

Thanks,

Mike Flynn
Principal Software Engineer
Enerdyne Technologies
8402 Magnolia Ave.
Suite C
Santee, CA 92041
Voice: 619-562-3061
Fax: 619-562-8802
MFlynn@Enerdyne.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
