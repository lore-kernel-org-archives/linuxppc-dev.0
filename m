Message-ID: <3827AC9F.5F4BFE01@jlc.net>
Date: Tue, 09 Nov 1999 00:09:51 -0500
From: Dan Malek <dmalek@jlc.net>
MIME-Version: 1.0
To: Peter Brown <pfb@syseng.anu.edu.au>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: MBX860 mbxroot.min problem.
References: <38266602.C333E608@syseng.anu.edu.au>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Peter Brown wrote:
> 
> I'm attempting to boot an MBX860 card using the mbxroot.min.tgz filesystem.

Other than this is all pretty old, it looks like it should boot fine.

> .....  When the NFS mount is attempted, the IP address of the NFS server
> appears to be corrupted from what was used before.


I don't understand what you mean by "corrupted".  The kernel used
the board configuration exactly.  Unless you manually enter a different
boot configuration line, the Linux/PPC boot assumes you are using the
same server the provided the kernel.

> ....  I've successfully executed
> the NFS mount on another network using the server address 192.168.1.1 and MBX
> address 192.168.1.4.


So, you have proven this works when the server is configured properly......

> ....  What would cause the boot arguments to be changed from
> the Program Load settings?


I don't understand what you mean.  Everything looks fine.



	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
