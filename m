From: "Wesley Felter" <wesf@cs.utexas.edu>
To: <linuxppc-dev@lists.linuxppc.org>
Subject: Installing pre-R5 via FTP
Date: Mon, 7 Dec 1998 21:34:09 -0600
Message-ID: <000101be225b$9dc14550$f53818d0@ender.Metropolis.waller.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I was looking forward to R5, but so far I've just been fighting the
installer.

I followed Martin Costabel's instructions and got the installer to run. I
partitioned a Jaz cart and entered my networking info in preparation for an
FTP install. But I have no DNS. When I typed in the IP address of
ftp.linuxppc.org, it couldn't contact the server.

Something is obviously wrong, but I have no idea what it is. I switched VCs
to the shell, but the installer doesn't come with ifconfig or anything
resembling it.

I'm not sure that I'm using the right kernel; I'm using the one downloaded
from ftp.linuxppc.org:/linuxppc/install/vmlinux. I haven't seen any others.

Any clues?

While I'm at it, here are some general comments about the installer:

DHCP doesn't work, at least not on the kernel I tried.

Selecting Disk Druid just produces a message saying that it doesn't work on
Macs.

Having the installer split into 1.4MB parts isn't necessary when using
BootX, so it'd be easier if it was just one part. Likewise, now that it's
not limited in size, an "expert" boot image that contains some extra
command-line tools would be welcome (to me at least).

Wesley Felter - wesf@cs.utexas.edu
"If I could be who you wanted" -- Radiohead


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
