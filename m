Message-Id: <199908201841.LAA16750@soda.CSUA.Berkeley.EDU>
To: toa@pop.agri.ch
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: MO-Disk on PPC with 53C94 SCSI-chip 
In-Reply-To: Your message of "Thu, 19 Aug 1999 20:08:50 +0200."
             <37BC482D.7EB2A4AF@pop.agri.ch>
Date: Fri, 20 Aug 1999 11:41:02 -0700
From: Sriranga Veeraraghavan <ranga@CSUA.Berkeley.EDU>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



Hi,

I had the exact same problem when trying to use by ORB drive with my
7600. The error messages were almost identical. 

I wasn't able to get it to work with under LinuxPPC, I also had
problems with the drive under Linux x86 when connected to a
AHA-2906. It works fine Linux x86 when connected to a AHA-1540.

I think that the problem has to do with the SCSI revision. 

----ranga <ranga@soda.berkeley.edu>

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
