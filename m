Message-ID: <3D04D6C0.9090202@embeddededge.com>
Date: Mon, 10 Jun 2002 12:41:36 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Christian Schroeder <christian.schroeder@imms.de>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: MPC850 USB
References: <1023715551.3d04a8dfbc9c4@imp.imms.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Christian Schroeder wrote:

> does anybody know, if the mpc850 (Mask rev. A, XPC850xxZTA) works
> as a usb hostcontroller or do I need at least mask rev. B ?

Well, "works" is a relative term.  The USB interfaces on these parts
were never really designed to be host controllers.  Depending upon
the application and the amount of software you want to write, you
can make them work.  There are some closed product, Rev. A parts using
the USB as a host controller.

Motorola listened to us (complaining :-), and did make some changes in
the Rev. B parts to reduce the software overhead, in particular the SOF
timing and the lower speed bus.  If you want to support a generic host
interface, you will have to use these parts along with the proper hardware
modifications outlined in their application notes.  There is Linux support
for these parts with these modifications.

Have fun!


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
