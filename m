Return-Path: <vantranbk@yahoo.com.au>
Received: from web33002.mail.mud.yahoo.com (web33002.mail.mud.yahoo.com
	[209.191.69.117]) by ozlabs.org (Postfix) with SMTP id 0791067B7C
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 26 Sep 2006 00:28:42 +1000 (EST)
Message-ID: <20060925142201.82489.qmail@web33002.mail.mud.yahoo.com>
Date: Tue, 26 Sep 2006 00:22:01 +1000 (EST)
From: tran vanle <vantranbk@yahoo.com.au>
Subject: Inet error in uClib
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1110198078-1159194121=:82066"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0-1110198078-1159194121=:82066
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi all
  I have just build uClibc -0.9.28 with ppc_85xx-gcc ,platform powerpc with kernel 2.6.15 and i have this error
  ppc_85xx-gcc  -Wall -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing    -fno-builtin -nostdinc -D_LIBC -I../../include -I.  -Os -funit-at-a-time   -isystem /prodev/csprj/tools/denx/usr/bin/../lib/gcc/powerpc-linux/4.0.0/include -DNDEBUG -fpic -D_DL_FINI_CRT_COMPAT -c ether_addr.c -o ether_addr.o
In file included from ../../include/linux/posix_types.h:47,
                 from ../../include/linux/types.h:13,
                 from ../../include/linux/if_ether.h:24,
                 from ../../include/netinet/if_ether.h:26,
                 from ../../include/netinet/ether.h:26,
                 from ether_addr.c:32:
../../include/asm/posix_types.h:10: error: conflicting types for '__kernel_ino_t'
../../include/bits/kernel_types.h:39: error: previous declaration of '__kernel_ino_t' was here
../../include/asm/posix_types.h:11: error: redefinition of typedef '__kernel_mode_t'
../../include/bits/kernel_types.h:40: error: previous declaration of '__kernel_mode_t' was here
../../include/asm/posix_types.h:12: error: redefinition of typedef '__kernel_off_t'
../../include/bits/kernel_types.h:42: error: previous declaration of '__kernel_off_t' was here
../../include/asm/posix_types.h:13: error: redefinition of typedef '__kernel_pid_t'
../../include/bits/kernel_types.h:43: error: previous declaration of '__kernel_pid_t' was here
../../include/asm/posix_types.h:14: error: redefinition of typedef '__kernel_uid_t'
../../include/bits/kernel_types.h:44: error: previous declaration of '__kernel_uid_t' was here
../../include/asm/posix_types.h:15: error: redefinition of typedef '__kernel_gid_t'
../../include/bits/kernel_types.h:45: error: previous declaration of '__kernel_gid_t' was here
../../include/asm/posix_types.h:16: error: redefinition of typedef '__kernel_ptrdiff_t'
../../include/bits/kernel_types.h:48: error: previous declaration of '__kernel_ptrdiff_t' was here
../../include/asm/posix_types.h:17: error: redefinition of typedef '__kernel_time_t'
../../include/bits/kernel_types.h:49: error: previous declaration of '__kernel_time_t' was here
../../include/asm/posix_types.h:18: error: redefinition of typedef '__kernel_clock_t'
../../include/bits/kernel_types.h:51: error: previous declaration of '__kernel_clock_t' was here
../../include/asm/posix_types.h:21: error: redefinition of typedef '__kernel_suseconds_t'
../../include/bits/kernel_types.h:50: error: previous declaration of '__kernel_suseconds_t' was here
../../include/asm/posix_types.h:22: error: redefinition of typedef '__kernel_daddr_t'
../../include/bits/kernel_types.h:52: error: previous declaration of '__kernel_daddr_t' was here
../../include/asm/posix_types.h:23: error: redefinition of typedef '__kernel_caddr_t'
../../include/bits/kernel_types.h:53: error: previous declaration of '__kernel_caddr_t' was here
../../include/asm/posix_types.h:24: error: redefinition of typedef '__kernel_uid16_t'
../../include/bits/kernel_types.h:55: error: previous declaration of '__kernel_uid16_t' was here
../../include/asm/posix_types.h:25: error: redefinition of typedef '__kernel_gid16_t'
../../include/bits/kernel_types.h:56: error: previous declaration of '__kernel_gid16_t' was here
../../include/asm/posix_types.h:26: error: redefinition of typedef '__kernel_uid32_t'
../../include/bits/kernel_types.h:57: error: previous declaration of '__kernel_uid32_t' was here
../../include/asm/posix_types.h:27: error: redefinition of typedef '__kernel_gid32_t'
../../include/bits/kernel_types.h:58: error: previous declaration of '__kernel_gid32_t' was here
../../include/asm/posix_types.h:28: error: redefinition of typedef '__kernel_old_uid_t'
../../include/bits/kernel_types.h:59: error: previous declaration of '__kernel_old_uid_t' was here
../../include/asm/posix_types.h:29: error: redefinition of typedef '__kernel_old_gid_t'
../../include/bits/kernel_types.h:60: error: previous declaration of '__kernel_old_gid_t' was here
../../include/asm/posix_types.h:38: error: redefinition of typedef '__kernel_nlink_t'
../../include/bits/kernel_types.h:41: error: previous declaration of '__kernel_nlink_t' was here
../../include/asm/posix_types.h:39: error: redefinition of typedef '__kernel_ipc_pid_t'
../../include/bits/kernel_types.h:54: error: previous declaration of '__kernel_ipc_pid_t' was here
../../include/asm/posix_types.h:40: error: redefinition of typedef '__kernel_size_t'
../../include/bits/kernel_types.h:46: error: previous declaration of '__kernel_size_t' was here
../../include/asm/posix_types.h:41: error: redefinition of typedef '__kernel_ssize_t'
../../include/bits/kernel_types.h:47: error: previous declaration of '__kernel_ssize_t' was here
../../include/asm/posix_types.h:42: error: redefinition of typedef '__kernel_old_dev_t'
../../include/bits/kernel_types.h:61: error: previous declaration of '__kernel_old_dev_t' was here
../../include/asm/posix_types.h:49: error: redefinition of typedef '__kernel_loff_t'
../../include/bits/kernel_types.h:62: error: previous declaration of '__kernel_loff_t' was here
../../include/asm/posix_types.h:55: error: conflicting types for '__kernel_fsid_t'
../../include/bits/kernel_types.h:67: error: previous declaration of '__kernel_fsid_t' was here
make[2]: *** [ether_addr.o] Error 1
make[2]: Leaving directory `/home/vantran/usr/src/uClibc/libc/inet'
make[1]: *** [_dir_inet] Error 2
make[1]: Leaving directory `/home/vantran/usr/src/uClibc/libc'
make: *** [_dir_libc] Error 2

   
  Please help me
  Thanks all

 		
---------------------------------
On Yahoo!7
  Break a world record with Total Girl's World’s Largest Slumber Party
--0-1110198078-1159194121=:82066
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<DIV>Hi all</DIV>  <DIV>I have just build uClibc -0.9.28 with ppc_85xx-gcc ,platform powerpc with kernel 2.6.15 and i have this error</DIV>  <DIV>ppc_85xx-gcc&nbsp; -Wall -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing&nbsp;&nbsp;&nbsp; -fno-builtin -nostdinc -D_LIBC -I../../include -I.&nbsp; -Os -funit-at-a-time&nbsp;&nbsp; -isystem /prodev/csprj/tools/denx/usr/bin/../lib/gcc/powerpc-linux/4.0.0/include -DNDEBUG -fpic -D_DL_FINI_CRT_COMPAT -c ether_addr.c -o ether_addr.o<BR>In file included from ../../include/linux/posix_types.h:47,<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from ../../include/linux/types.h:13,<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from ../../include/linux/if_ether.h:24,<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from
 ../../include/netinet/if_ether.h:26,<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from ../../include/netinet/ether.h:26,<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from ether_addr.c:32:<BR>../../include/asm/posix_types.h:10: error: conflicting types for '__kernel_ino_t'<BR>../../include/bits/kernel_types.h:39: error: previous declaration of '__kernel_ino_t' was here<BR>../../include/asm/posix_types.h:11: error: redefinition of typedef '__kernel_mode_t'<BR>../../include/bits/kernel_types.h:40: error: previous declaration of '__kernel_mode_t' was here<BR>../../include/asm/posix_types.h:12: error: redefinition of typedef '__kernel_off_t'<BR>../../include/bits/kernel_types.h:42: error: previous declaration of '__kernel_off_t' was here<BR>../../include/asm/posix_types.h:13: error: redefinition of typedef '__kernel_pid_t'<BR>../../include/bits/kernel_types.h:43: error:
 previous declaration of '__kernel_pid_t' was here<BR>../../include/asm/posix_types.h:14: error: redefinition of typedef '__kernel_uid_t'<BR>../../include/bits/kernel_types.h:44: error: previous declaration of '__kernel_uid_t' was here<BR>../../include/asm/posix_types.h:15: error: redefinition of typedef '__kernel_gid_t'<BR>../../include/bits/kernel_types.h:45: error: previous declaration of '__kernel_gid_t' was here<BR>../../include/asm/posix_types.h:16: error: redefinition of typedef '__kernel_ptrdiff_t'<BR>../../include/bits/kernel_types.h:48: error: previous declaration of '__kernel_ptrdiff_t' was here<BR>../../include/asm/posix_types.h:17: error: redefinition of typedef '__kernel_time_t'<BR>../../include/bits/kernel_types.h:49: error: previous declaration of '__kernel_time_t' was here<BR>../../include/asm/posix_types.h:18: error: redefinition of typedef '__kernel_clock_t'<BR>../../include/bits/kernel_types.h:51: error: previous declaration of '__kernel_clock_t' was
 here<BR>../../include/asm/posix_types.h:21: error: redefinition of typedef '__kernel_suseconds_t'<BR>../../include/bits/kernel_types.h:50: error: previous declaration of '__kernel_suseconds_t' was here<BR>../../include/asm/posix_types.h:22: error: redefinition of typedef '__kernel_daddr_t'<BR>../../include/bits/kernel_types.h:52: error: previous declaration of '__kernel_daddr_t' was here<BR>../../include/asm/posix_types.h:23: error: redefinition of typedef '__kernel_caddr_t'<BR>../../include/bits/kernel_types.h:53: error: previous declaration of '__kernel_caddr_t' was here<BR>../../include/asm/posix_types.h:24: error: redefinition of typedef '__kernel_uid16_t'<BR>../../include/bits/kernel_types.h:55: error: previous declaration of '__kernel_uid16_t' was here<BR>../../include/asm/posix_types.h:25: error: redefinition of typedef '__kernel_gid16_t'<BR>../../include/bits/kernel_types.h:56: error: previous declaration of '__kernel_gid16_t' was
 here<BR>../../include/asm/posix_types.h:26: error: redefinition of typedef '__kernel_uid32_t'<BR>../../include/bits/kernel_types.h:57: error: previous declaration of '__kernel_uid32_t' was here<BR>../../include/asm/posix_types.h:27: error: redefinition of typedef '__kernel_gid32_t'<BR>../../include/bits/kernel_types.h:58: error: previous declaration of '__kernel_gid32_t' was here<BR>../../include/asm/posix_types.h:28: error: redefinition of typedef '__kernel_old_uid_t'<BR>../../include/bits/kernel_types.h:59: error: previous declaration of '__kernel_old_uid_t' was here<BR>../../include/asm/posix_types.h:29: error: redefinition of typedef '__kernel_old_gid_t'<BR>../../include/bits/kernel_types.h:60: error: previous declaration of '__kernel_old_gid_t' was here<BR>../../include/asm/posix_types.h:38: error: redefinition of typedef '__kernel_nlink_t'<BR>../../include/bits/kernel_types.h:41: error: previous declaration of '__kernel_nlink_t' was
 here<BR>../../include/asm/posix_types.h:39: error: redefinition of typedef '__kernel_ipc_pid_t'<BR>../../include/bits/kernel_types.h:54: error: previous declaration of '__kernel_ipc_pid_t' was here<BR>../../include/asm/posix_types.h:40: error: redefinition of typedef '__kernel_size_t'<BR>../../include/bits/kernel_types.h:46: error: previous declaration of '__kernel_size_t' was here<BR>../../include/asm/posix_types.h:41: error: redefinition of typedef '__kernel_ssize_t'<BR>../../include/bits/kernel_types.h:47: error: previous declaration of '__kernel_ssize_t' was here<BR>../../include/asm/posix_types.h:42: error: redefinition of typedef '__kernel_old_dev_t'<BR>../../include/bits/kernel_types.h:61: error: previous declaration of '__kernel_old_dev_t' was here<BR>../../include/asm/posix_types.h:49: error: redefinition of typedef '__kernel_loff_t'<BR>../../include/bits/kernel_types.h:62: error: previous declaration of '__kernel_loff_t' was
 here<BR>../../include/asm/posix_types.h:55: error: conflicting types for '__kernel_fsid_t'<BR>../../include/bits/kernel_types.h:67: error: previous declaration of '__kernel_fsid_t' was here<BR>make[2]: *** [ether_addr.o] Error 1<BR>make[2]: Leaving directory `/home/vantran/usr/src/uClibc/libc/inet'<BR>make[1]: *** [_dir_inet] Error 2<BR>make[1]: Leaving directory `/home/vantran/usr/src/uClibc/libc'<BR>make: *** [_dir_libc] Error 2<BR></DIV>  <DIV>&nbsp;</DIV>  <DIV>Please help me</DIV>  <DIV>Thanks all</DIV><p>&#32;
		<hr size=1>On Yahoo!7<br> 
<a 
href="http://au.rd.yahoo.com/mail/tag/totalgirl/SIG=11j8a9mso/**http%3A%2F%2Fwww.totalgirl.com.au%2Fslumberparty"> 
Break a world record with Total Girl's World’s Largest Slumber Party</a>
--0-1110198078-1159194121=:82066--
