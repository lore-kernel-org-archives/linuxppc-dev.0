Message-ID: <3B573CB9.6000307@ccc-dcs.com>
Date: Thu, 19 Jul 2001 15:02:01 -0500
From: Jim Duey <jduey@ccc-dcs.com>
MIME-Version: 1.0
To: linuxppc <linuxppc-embedded@lists.linuxppc.org>
Subject: SMBFS
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I'm trying to get Samba running on a Walnut board.  I've got everything
compiled and I can connect to SMB shares on Windows machines using
smbclient, but I can't get smbfs support compiled into the kernel so I
can mount Windows shares in the directory tree.  I'm using Monta Vista's
HHL 1.2 kit and I've download the latest version of the kernel sources
from the ftp site.  When I run 'make menuconfig', I can select SMB
support and 'make dep' and 'make zImage' complete with no errors.
 However, after booting the board, smbfs support doesn't appear in
/proc/filesystems.  Is this somehow disabled in the HHL distribution of
the kernel?  If not, can someone point me to the file controls the
inclusion of SMB into the kernel?

Thanks
Jim

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
