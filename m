Subject: usb function driver
Date: Fri, 27 Jul 2001 13:42:32 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Message-ID: <EADB10BAC266A14A85ECBF8686A73E31459233@kolkrabbi.flaga.is>
From: =?iso-8859-1?B?S+FyaSBEYXbt8HNzb24=?= <kd@flaga.is>
To: "Linux Embedded ppc (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I am playing around with the usb function driver from the old linux_2_5
source tree.
When ever I connect the device to a usb host I get a sequence of idle
and reset events.
As far as I can gather from the usb docs the host should respond with
USB device request
on the default control pipe (address 0 endpoint 0). The host now starts
by enumerating the
devices which ends with a unique (per bus I believe) number assigned to
the device. After that
the device is addressed with this unique number.

By monitoring the bus with o.scope I can see the sofs flowing for a
while after plugging in the
device. But none of the sofs are cought by the cpm, nor any usb device
requests.

The host is a dual cpu w2k machine with intel chipset.

I have gone over the initialisation and setup of the USB part of the cpm
couple of times and do not see anything strange compared to the mpc823e
documentation.

I am using BRG4 for USB clock.

Any ideas?

Thanks,

K.D.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
