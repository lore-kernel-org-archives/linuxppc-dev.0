Message-Id: <199904221923.OAA26620@lists.linuxppc.org>
Date: Thu, 22 Apr 1999 15:23:02 -0400
From: "Williams, Murray Todd" <murray_williams@merck.com>
Subject: Wacom Intuos Graphics Tablet and the USB iMac
To: "'linuxppc-user@lists.linuxppc.org'" <linuxppc-user@lists.linuxppc.org>,
        "'linuxppc-dev@lists.linuxppc.org'" <linuxppc-dev@lists.linuxppc.org>
MIME-version: 1.0
Content-type: text/plain
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I've noticed that there is a pretty functinal driver for XFree86 (Xinput)
for the Wacom Intuos graphics tablet, which is basically a generic serial
device.  ( http://www.levien.com/free/linux_intuos.html ) and I also see
that Wacom describes how to get the serial-port (PC) Intuos to work on an
iMac (USB) via a simple USB-to-serial converter.  (
http://www.wacom.com/productsupport/usb.html )

So here's the question: I know that right now we only have USB mice and
keyboards working on the iMac.  Does anyone know how easy or hard it would
be to get a standard serial device on the USB interface to map to a port
(e.g. /dev/ttyS1 or something) so that I could try to compile the Xinput
driver on an iMac?

On the surface, this sounds like a simple thing, but I know absolutely
nothing about Mac serial devices (/dev/ttySx) or the USB standards.

Any thoughts?

Murray Todd Williams
murray_williams@merck.com

P.S. If you're reading this on the linuxppc-dev list, e-mail a response to
me directly.  I haven't put myself on that mailing list (yet).

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
