Return-Path: <owner-linuxppc-dev@lists.linuxppc.org>
Mime-Version: 1.0
Message-Id: <p06010202bc333bc03e48@[192.168.9.5]>
Date: Tue, 20 Jan 2004 15:27:38 -0500
To: linuxppc-dev@lists.linuxppc.org
From: Stefan Jeglinski <jeglin@4pi.com>
Subject: how to pass kernel command parameters?
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I have a Brightstar box with an MPC823, booting under 2.4.21 at the
moment. But at the "Linux/PPC load:" line I have to enter a rather
long string of parameters (IP numbers etc), I guess due to the boot
ROM code that's part of this little Brightstar device.

What is the proper way to automate the passing of these parameters?
I'm gathering that all ppc kernel boots have this line to stop at,
but the passing of parameters to it is automated.

Should I be constructing a custom ram disk that contains the info? If
so, what's a good resource about making ram disks and how to do this?
If not, how is one supposed to do it? I don't suppose one should be
hard-coding misc-simple.c or misc-embedded.c... ?


Stefan Jeglinski

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
