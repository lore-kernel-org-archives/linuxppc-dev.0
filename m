Message-ID: <375D3258.54D3694B@fi.infn.it>
Date: Tue, 08 Jun 1999 17:10:16 +0200
From: Simone Piccardi <Simone.Piccardi@fi.infn.it>
MIME-Version: 1.0
To: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: How to boot VME from HD?
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,
I just got a new disk for our MVME2431 board. Up to now I was booting
trough NFS using a kernel image and a root filesystem on a linux PC.
Then I just copied all the files from the NFS root directory on the PC
to the new disk, and after few adjustement (correction on fstab) I could
have the root filesystem on the HD, uding it after boot.
Now I would like to go further and boot directly from the HD, removing
the needing of the PC; I looked into PPCBUG manual, finding the PBOOT
command; but it require a bootable partition and a boot record, and I
think that lilo did not work in these board, there is an equivalent
tool? Or I can simply put the kernel image inside the NV Ram and start
from there? 
Ok, the problem is not serious, all the other things are working well; I
only would like to have a faster way to boot.
Bye
-- 
Simone Piccardi
Microsoft is NOT the answer. Microsoft is the Question.
The answer is: "NO!"

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
