Date: 12 Jun 2002 15:08:03 -0000
Message-ID: <20020612150803.22835.qmail@webmail21.rediffmail.com>
MIME-Version: 1.0
From: "navinb" <ppc4@rediffmail.com>
Reply-To: "navinb" <ppc4@rediffmail.com>
To: linuxppc-embedded@lists.linuxppc.org
Cc: linux-usb-devel@lists.sourceforge.net
Subject: usb slave driver problem..
Content-type: text/plain;
	format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I have three quick questions for USB people.

1.if anybody has tested usb slave mode on mpc823
pls. let me know the setup details like it was tested with which
host , at low or high speed and similar relevant stuff or any
problems faced..

is there any existing slave driver for that ?

2.I am getting repeated USB RESET events on host side..I feel
posible cause can be cable/connectors as i am using both side
series A plug for for two identical 823 boards one running host
anothe slave , though i am using the prescribed bit to achieve a
1.5k pulldown to make it a usb device.

3.in slave driver all the descriptor data that has to be supplied
to host is to be known beforehand from vendor or it has to be
retrieved from hardware ?
this question I asked because I spent some time in reading about
USB but couldn't find explicit answer to this.

Best Regards,


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
