Message-Id: <sbc6f825.063@tms-pty.com>
Date: Fri, 12 Oct 2001 14:03:05 +1100
From: "Jeremy Rosen" <Rosen.Jeremy@tms-pty.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Problem to wiggler
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello everybody, I am not sure this is the right list to ask this
question, but I don't know where to ask...

I am trying to downlooad an image to a FADS860T board via a wiggler on
lpt0.

I am using the cross gdb wich is available on OCdemon web site, but
when I try to "set target ocd wiggler 0", it complains that it doesn't
find the device ocdemonpp0. Wich effectively isn't here. It seems that
the rpm failed to create the entry in /dev, so I looked in the
device.txt of my kernel to find the major and minor to create the device
myself, but it wasn't registered.

How can I use this device under linux ?
Could anybody give me the right major and minor ???

Thanks
Jeremy


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
