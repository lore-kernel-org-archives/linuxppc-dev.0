Date: Fri, 11 Oct 2002 18:30:08 +0200
Mime-Version: 1.0 (Apple Message framework v482)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: Fwd: Problems with linuxppc_2_4_devel and linuxppc_2_4
From: Anders Blomdell <anders.blomdell@control.lth.se>
To: linuxppc-embedded@lists.linuxppc.org
Message-Id: <B4D84098-DD36-11D6-99DE-0003931C2BFA@control.lth.se>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I'm still having problems boooting both linuxppc_2_4 and linuxppc_2_4_devel
on my MVME2600-1. With linuxppx_2_4 I get garbled data from 'Now booting th
kernel'
until init starts to run, linuxppc_2_4_devel failss to boot, but that is
probably due to some NFS problem (hard to say with the current sad state of
console output, though).

  Linux/PPC load: console=ttyS0,9600 root=/dev/nfs ip=on
  Uncompressing Linux...done.
  Now booting the kernel
   ...Lots of garbled data deleted...
   init-2.03#
   init-2.03#

My question's now are:

   1. Which driver is expected to take care of the console messages on a
      MVME2600-1 (and hence probably responsible for the garbled data)?
   2. Have I forgotten some important switch on the boot line?

Regards

Anders Blomdell


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
