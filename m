Date: Wed, 30 Jun 2004 11:12:18 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
To: Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
Subject: looking for .config file for RPXlite board for 2.6 kernel
Message-ID: <Pine.LNX.4.60.0406301107130.18110@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


   ok, in the interests of my mental health, i've grabbed an rpxlite
board off the shelf, and am going to see how far i can boot it with
the current 2.6 kernel.

   does someone have a .config file for this that i can use as a
starting point?  and how that would affect what i should select as the
console on the boot command line?  (console=???).

   from memory, when i tried this once upon a time, i got as far as

Now booting the kernel

so i suspect that i misconfigured the console in some way.  thoughts?
i've been told that this board has

   SMC1 UART
   SCC2 Ethernet

but i'll make sure of that shortly.

rday

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
