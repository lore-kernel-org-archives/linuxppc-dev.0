Date: Tue, 13 Nov 2001 15:10:24 -0800 (PST)
From: James Simmons <jsimmons@transvirtual.com>
To: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: 2.5.X work
Message-ID: <Pine.LNX.4.10.10111131509560.19489-100000@transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi!

   As some of you know I have been working on a new console system for
2.5.X. Now that 2.5.X is very very close I really like to work together
with various people from various trees to pull this together. The two
biggest changes I have done is:

1) A new fbdev api with is much simpler and allows fbdev devices to exist
   without a console system. Nice for embedded devices.

2) We also will be moving the various input devices including keyboards
   over to the input api.

3) Also I plan to work on a new serial api based on Russell King's work to
   work nicely with the input layer. The serial layer will be more like
   the parallel port layer.

So what I need is the latest drivers from people so they can be ported
over. I also want to know what people needed for the fbdev layer as well
as the input layer. I see some email about DDC support for example. Please
let me know what you need. Thank you.



_______________________________________________
http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
Please visit the above address for information on this list.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
