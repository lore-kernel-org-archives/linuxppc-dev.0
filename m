Message-ID: <38F76238.499D12F9@colorkinetics.com>
Date: Fri, 14 Apr 2000 14:23:52 -0400
From: Ihor Lys <ihor@colorkinetics.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Need suggestions......
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Everybody.....

I am currently in the process of figuring out what the minimum external
hardware requirements would be for a new project we are working on.

We currently use a motorola FADS board with an 850SAR for some other
non-linux development, has anyone booted linux on this configuration?

For various reasons we would like to run linux on either a MPC850SR or
or MPC860SR or MPC860T.
The final design of our system will be custom, but as usual, its
probably beasier to start with something semi-standard.
We don't need most of the goofy desktop stuff, (video, HDD, FDD, swap,
etc), but we do need ethernet, serial, and other I/O

Further: Can anyone tell me:
Which SIMPLE SBC boards work with a minimum of fuss.
What kind of driver support is there for perhipherals based on USB
How much ram is really needed for the kernel image itself
What minimum external perhipherals other than I/O are needed/supported?
(RTC? NVRAM?)
Is there any reference as to what external perhipherals might be
supported? Like external UARTs, Net adapters, PCMCIA cards, etc?

Thanks
Ihor



--
------------------------------------------------------
Ihor Lys                             TEL: 617-423-9999
Color Kinetics Inc.                  FAX: 617-423-9998
50 Milk St. 17th Floor               CEL: 617-899-4320
Boston, MA 02109                 www.colorkinetics.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
