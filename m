Date: Sat, 24 Jul 2004 09:14:08 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
To: Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
Subject: couple questions about MPC8xx CPM Options menu
Message-ID: <Pine.LNX.4.60.0407240909090.12370@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


   is there some rationale for the 8xx CPM options menu to contain
entries for either of:

   860T FEC Ethernet
   CPU6 Silicon Errata (860 Pre Rev. c)

   the first has a help entry that refers, not to the 860, but to the
8260 (making it out of place here).

   and the second, while being in the 8xx family, is still displayed
even after choosing a platform that's not an 860.  (the same can be
said for the first option as well -- why is it still available if one
selects, say, the 850-based rpxlite?)

   this is the sort of confusion i was talking about in my earlier
emails.

rday

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
