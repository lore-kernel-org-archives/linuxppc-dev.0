Date: 10 Jun 2002 08:44:44 -0000
Message-ID: <20020610084444.8528.qmail@webmail14.rediffmail.com>
MIME-Version: 1.0
From: "navinb" <ppc4@rediffmail.com>
Reply-To: "navinb" <ppc4@rediffmail.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: usb host and slave connection....
Content-type: text/plain;
	format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

If any body has tested MPC8xx board in usb slave mode i have quick
maybe naive question here.

A host does have two 10k pull up resistor on data lines where as a
device as one 1.5k pulldown on appropiate dataline ( high/low
speed) , now how the same port can be used as host and slave  mode
both.

mpc8xx have series A usb receptable which normally resides toward
host side.

I am asking this question because i am getting repeated reset
events when I connect one mpc8xx board running as slave connected
by a normal usb cable ( i assume it is a high speed cable used for
12/480 mbs) to another mpc8xx board running as host ..and both
identical board have series A receptable.

Best Regards,


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
