To: "leeyang" <leeyang@ycig.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: eldk2.1.0 open-ssl-devel-ppc_82xx on leo is borken 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 25 Apr 2003 13:35:06 +0800."
             <011d01c30aec$6f584000$cc00a8c0@ycigrnd>
Date: Fri, 25 Apr 2003 09:12:09 +0200
Message-Id: <20030425071214.B807FC5A97@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <011d01c30aec$6f584000$cc00a8c0@ycigrnd> you wrote:
> I have downloaded eldk2.1.0 eldk_ppc_linux_x86,
> but  only
> ftp://ftp.leo.org/.mntpts/3/pub/comp/os/unix/linux/eldk/2.1.0/eldk-ppc-linux
> -x86/ppc_82xx/RPMS/openssl-devel-ppc_82xx-0.9.6b-8.ppc.rpm
> can not be successfully got,always broken down by server.

Please use the official URL, ftp://ftp.leo.org/pub/eldk/...

> I tried with different ftp clients, and the same,
> Maybe the file is corrupt.

No, it is not. It's working fine here:

...
-> ncftp ftp://ftp.leo.org/pub/eldk/2.1.0/eldk-ppc-linux-x86/ppc_82xx/RPMS/
NcFTP 3.1.3 (Mar 27, 2002) by Mike Gleason (ncftp@ncftp.com).
Connecting to ftp.leo.org(131.159.72.23)...
 ****************************************************************************
 Welcome to LEO.ORG. Please login as `ftp' to access our archive.
...
Guest login ok, access restrictions apply.
Logged in to ftp.leo.org.
Current remote directory is /.mntpts/3/pub/comp/os/unix/linux/eldk/2.1.0/eldk-ppc-linux-x86/ppc_82xx/RPMS.
ncftp ...inux-x86/ppc_82xx/RPMS > bin
ncftp ...inux-x86/ppc_82xx/RPMS > get openssl-devel-ppc_82xx-0.9.6b-8.ppc.rpm
openssl-devel-ppc_82xx-0.9.6b-8.ppc.rpm:                 1.21 MB   86.29 kB/s
ncftp ...inux-x86/ppc_82xx/RPMS > by
-> ls -l openssl-devel-ppc_82xx-0.9.6b-8.ppc.rpm
-rw-r--r--    1 wd       users     1265789 Apr  8 16:26 openssl-devel-ppc_82xx-0.9.6b-8.ppc.rpm


> And it seems that there is a file missed in
> eldk2.1.0 eldk_arm_linux_x86,which named
> /arm_920TDI/RPMS/binutils-doc-2.11.93.0.2-3b_2.i386.rpm
> according MD5SUM file comes with the package.

No, you are wrong.

The MD5SUM file contains 3 entries for "binutils" RPMS, and all three
files are there:

-> grep binutils MD5SUM.txt
19dabbee4dcd26d92ca4ee959015d821  RPMS/binutils-arm-2.11.93.0.2-3b_2.i386.rpm
573b7aa50841ec29cdd7ffdba467952d  RPMS/binutils-doc-2.11.93.0.2-3b_2.i386.rpm
3e12de4e7cb8d2ef357f51f9d8f8ea27  arm_920TDI/RPMS/binutils-arm_920TDI-2.11.93.0.2-3b_2.arm.rpm
-> ls -l RPMS/binutils-arm-2.11.93.0.2-3b_2.i386.rpm \
> RPMS/binutils-doc-2.11.93.0.2-3b_2.i386.rpm \
> arm_920TDI/RPMS/binutils-arm_920TDI-2.11.93.0.2-3b_2.arm.rpm
-rw-r--r--    1 root     root      2041014 Apr  8 02:52 RPMS/binutils-arm-2.11.93.0.2-3b_2.i386.rpm
-rw-r--r--    1 root     root       451882 Apr  8 02:52 RPMS/binutils-doc-2.11.93.0.2-3b_2.i386.rpm
-rw-r--r--    1 root     root      1820824 Apr  8 04:42 arm_920TDI/RPMS/binutils-arm_920TDI-2.11.93.0.2-3b_2.arm.rpm


> Anyway it is a doc file.

There is no "doc" RPM in the target directory,  maybe  this  confused
you.


Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
I had a letter in the post today.   It said 'Gas Bill'.   It sounds a
tempting offer...

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
