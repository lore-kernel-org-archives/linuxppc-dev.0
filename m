Date: Thu, 13 Feb 2003 14:19:41 -0600 (CST)
From: vinai <vroopcha@mcw.edu>
To: "LinuxPPC Developers' List" <linuxppc-dev@lists.linuxppc.org>
Subject: vmalloc limits in PPC kernels ?
Message-ID: <Pine.LNX.4.44.0302131412270.278-100000@kaiso.biophysics.mcw.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hey Folks,

I've been doing a little work trying to update an in-house custom driver
for x86.  We acquired fairly large chunks of data, and we can't afford
to lose any of it. To do this, we reserve a fairly large chunk of memory
in which the data can be stored, as we can't afford system latencies
when writing to disk.  We were able to this in 2.2 without any problems,
but in 2.4, a new "feature" was introduced to x86 that limited how much
memory one can "vmalloc".  I did a quick check, but didn't find anything
in the ppc asm directory.  Do we have such a limit ?

cheers
vinai

"I can't understand people who hate other people based on things like race,
 religion, or sexual orientation.  When you really do get to know a person,
 aren't there so many more worthwhile reasons for despising them ?"

                                        Dennis Miller

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
