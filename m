Message-ID: <3855521D.A3C376A8@netx4.com>
Date: Mon, 13 Dec 1999 15:07:57 -0500
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: diekema_jon <diekema@bucks.si.com>
CC: linuxppc-embedded@lists.linuxppc.org, r36232@email.sps.mot.com
Subject: Re: What is the status of the Linux MPC8240/MPC8260 port?
References: <m11xZYu-001SzVC@bucks>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


diekema_jon wrote:


>         * What is the status of the Linux MPC8240/MPC8260 port?


I now have access to Cort's BitKeeper, so I will be merging
the 8240 I have and it will soon show up in the real sources.
If you want something to patch, I created a tar file of the
new files and those that have changed.  Let me know and I
can make that available.  It is just the result of my separating
the changes for merging.

I was contracted to do the 8260 port by a company and they
currently have the first version of that software.  I will
check in all of the software affected by GPL, which isn't
everything at this time.  I am not going to screw around with
software patches for anything less than an A.0 revision part.


>         Since that time, Dennis Kung (r36232@email.sps.mot.com) from
>         Motorola Asia-Pacific reports LinuxPPC running the Sandpoint
>         MPC8240 reference platform.


I have contacted Dennis about this software, we discussed some
of the porting challenges.  I requested this software to merge
with mine before checking into CVS, but have not received a
response.



>         What CVS root is capturing the 82xx development activity?

I should end up in the "real" Linus kernels almost as quickly as
we make the updates.  I don't think there will be a separate "tree
in waiting"....

FYI, there is nothing common between the 8240 and 8260 ports,
except their use of the 603 core generic software.  The 8240 is
a 603 with a slightly modified 106/107 PCI interface.  The 8260 is
a faster 860.....Very different kernel builds.



	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
