From: John_McRoberts@Mitel.COM
To: "PAULO SELEME CORREA PAULO" <paulo.correa@siemens.com.br>
Cc: linuxppc-embedded@lists.linuxppc.org
Message-ID: <85256AE6.004907C3.00@kanmta01.software.mitel.com>
Date: Mon, 15 Oct 2001 14:19:40 +0100
Subject: Re: ethernet driver source
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


From:  John McRoberts@MITEL on 10/15/2001 02:19 PM GDT
at the linux menuconfig:

turn on the 10/100 network interfaces and disable all the entries.

The go to the MPC860 specific stuff where lo and behold you'll find that the CPM
and FEC have both appeared.

Enable the one you require.

Took me a while but I got there in the end....

John


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
