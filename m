Date: Fri, 9 Jul 2004 13:38:55 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
To: Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
Subject: should "860T FEC Ethernet" be an option for 8xx?
Message-ID: <Pine.LNX.4.60.0407091333510.13457@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


   under "MPC8xx CPM Options", we have:

      [ ] 860T FEC Ethernet

whose help reads:

   Enable Ethernet support via the Fast Ethernet Controller (FCC) on
   the Motorola MPC8260.

   but if it's specific to the 8260, it shouldn't even be available in
the menu for 8xx, no?  either that, or the help is wrong.

rday

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
