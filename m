Message-Id: <l03130300b2dc4c48460b@[172.16.10.14]>
In-Reply-To: <199902012323.KAA24452@tango.anu.edu.au>
References: <l03130300b2dbb10d21bc@[172.16.10.14]> (message from Bryan
 Christianson on Tue, 2 Feb 1999 08:42:28 +1300)
 <l03130300b2dbb10d21bc@[172.16.10.14]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Tue, 2 Feb 1999 19:33:23 +1300
To: Paul.Mackerras@cs.anu.edu.au
From: Bryan Christianson <bryanc@ihug.co.nz>
Subject: Re: I/O Port Conflicts with PCI devices?
Cc: linuxppc-dev@lists.linuxppc.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



>Most likely neither devices is responding to I/O-space accesses
>because the PCI_COMMAND_IO bit (enable response to I/O space accesses)
>in the PCI command register isn't set.  That would explain the machine
>check when you try to access the device.
>
>Paul.


Thanks Paul. The drivers I looked at implied that this was required only
for broken Windows98 BIOS, but applying the code to LinuxPPC has fixed the
problem.

Bryan

--
Bryan Christianson
email:		<mailto:bryanc@ihug.co.nz>
Home Page:	<http://crash.ihug.co.nz/~bryanc>



[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
