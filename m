Subject: getting linux console on a frame buffer.
To: linuxppc-dev@lists.linuxppc.org
Message-ID: <OF3B6896EC.3575AD9B-ON85256E98.004FD727-85256E98.00510EB2@nanometrics.ca>
From: David Ho <DavidHo@nanometrics.ca>
Date: Tue, 18 May 2004 10:45:21 -0400
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all,

I am new to this list.  I interact mostly on the embedded since I am
working mostly on embedded devices.  I definitely need some help that
embedded folks don't normally do!

I have a 240*320 16bpp LCD (framebuffer) attached to a MPC852T that I have
trouble running simple tests like rendering an image directly to the
framebuffer using fbi from Gerd Knorr.  I have already dump rawimage by
catting to the /dev/fb0 device.  I am at a point where I like to understand
the byte ordering and image rendering issues with jpeg and png files.

The problem may be that I don't have a linux console running on the frame
buffer device.  Would anyone know how to get the linux console on the frame
buffer but still receives input from a serial port (I don't have a keyboard
attached to the board.  I have been doing most things from the serial
console and remotely).

Thanks a lot!

David Ho
Nanometrics Inc


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
