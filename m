Message-ID: <3C9E2500.4477166B@lvl7.com>
Date: Sun, 24 Mar 2002 14:12:00 -0500
From: Neil Horman <nhorman@lvl7.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: question regarding organization of the pte hash table
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello all-
	If anyone has a free moment, I'm looking for education regarding the
organization and manipulation of the hash table which stores pte that are not
listed in the TLB or software tables used by the MMU.  From what I read
regarding the use of the PPC860 MMU (my processor in question), multiple page
tables/directories are interleaved through the use of the ASID/CASID identifiers
which must match for a MMU translation to be successful.  If I understand it
correctly the hash table stores pte's which have been victimized from the MMU
TLB and/or software tables due to another memory context (CASID) using that same
virtual address.  If that is correct, then I would like to better understand the
hashing functions which the hash table uses to store ptes with identical virtual
address and different CASID's.  Also, if my previous thinking is correct, the
hash table in question must be limited in the number of CASID's which it
supports, and consequently, the number of processes which can be run at any one
time.  How is that limit determined?.  If anyone knows of any documentation on
the subject, or knows where in the source tree I can get a better understanding
of the hash tables function I'd certainly appreciate it.  I've tried to glean
something from hash_page down in hashtable.S and I'm really quite lost.  Thanks
all!
Neil

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
