Message-ID: <369F393C.56F964FF@ibm.net>
Date: Fri, 15 Jan 1999 07:49:00 -0500
From: Frederick Heitkamp <fheitka@ibm.net>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: anyone used kgdb lately?
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I've been trying to set up my APUS and my PC so I can run a kgdb kernel
on
APUS to possibly figure out (or at least gather enough  information so
someone else can help) why my A4000T SCSI locks up randomly when using
APUS.  Note I've checked and rechecked termination and hardware issues
and
am assuming that that's not the problem (for better or worse).  I've
built gdb-4.17
with target powerpc-linux and installed it on my PC.  I've connected a
null modem
cable between the PC and the Amiga and tested it using kermit.  I used a
non-stripped
powerpc kernel as input to gdb and started up the stripped version on
the Amiga.
I put the command line option debug=/dev/ttyS0 in the boothack script
and tried
to start the kernel.  Here's where things go sour.   The stripped kernel
doesn't start
at all.  By reading the docs in  arch/m68k/kernel/kgdb it seems to say
that the kernel
should work normally if the above debug option is removed.  I  tried
removing the
debug=/dev/ttyS0  option from the command line and still the kernel does
not  boot.
My question is,  has anyone used the kgdb option on APUS or any PPC
lately
and does it work?  I've compiled several kernels (using the same source)

without kgdb support and they have worked fine.  I assume The kgdb
code tries to initize the serial port first thing.  Is that a good place
to start
troubleshooting?

Fred



[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
