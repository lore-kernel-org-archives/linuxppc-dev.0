Message-ID: <3A9EB4FA.6B8D956E@snmc.com>
Date: Thu, 01 Mar 2001 14:45:46 -0600
From: Daris A Nevil <dnevil@snmc.com>
MIME-Version: 1.0
To: Peter Uttley <P.Uttley-97@student.lboro.ac.uk>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: How can I slim down libc
References: <000001c0a273$b7765c20$74dee783@lboro.ac.uk>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Pete,

You may want to look at the QSLinux kernel at http://qslinux.org and
ftp://qslinux.org.  We have integrated the e2fs-compr Extended-2
Filesystem into the kernel.  We can fit the Libc, Libdll, and two or
three other libs, plus the executables for bash, ftp, telnet, and snmp
into 3Meg of FLASH compressed, and still have room left over.


Regards,
Daris Nevil


Peter Uttley wrote:
>
> Hope someone can point me in the right direction.
>
> I'm currently developing an embedded system based on an MPC-850, and
> everything going quite well, however I'm currently mounting my file system
> on NFS and now want to run from a ram disk.
> Unfortunately I only have 8MB of RAM to play with and Libc on it's own is
> 4MB, I've tried removing debug information but this doesn't get me down much
> further.
>
> Any help on this matter would be highly appreciated,
>
> Regards,
>
> Pete.
>

--
Daris A Nevil
Simple Network Magic Corporation
401 Kentucky Lane
McKinney, TX 75069
214-793-7757
dnevil@snmc.com
www.snmc.com
quickstack.com
qslinux.org

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
