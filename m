Return-Path: <indianirav@yahoo.com>
Received: from web43101.mail.sp1.yahoo.com (web43101.mail.sp1.yahoo.com
	[216.252.121.1]) by ozlabs.org (Postfix) with SMTP id 6D30FDDE40
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  5 Feb 2007 00:08:59 +1100 (EST)
Date: Sun, 4 Feb 2007 05:02:18 -0800 (PST)
From: patel nirav <indianirav@yahoo.com>
Subject: problem : cross compiling the kernel
To: linux ppc <linuxppc-embedded@ozlabs.org>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-574786317-1170594138=:10578"
Message-ID: <655529.10578.qm@web43101.mail.sp1.yahoo.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0-574786317-1170594138=:10578
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hello friends greeting all.
 
 i am trying to cross compile the linux kernel 2.4.18  for powerpc604.( i am using gcc 3.4.1 glibc 2.3.3 binutils 2.15)
 so i installed the cross tool at /opt/crossool/.....
 and run following commands
 [root@nirav linux-2.4.18]# make ARCH=ppc menuconfig    
 [root@nirav linux-2.4.18]# make ARCH=ppc CROSS_COMPILE=powepc-604-linux-gnu- dep zImage
 and i found following problems.      
 
 /home/nirav/RTAI/linux-2.4.18/include/asm/unistd.h:415: warning: conflicting types for built-in function '_exit'
 /home/nirav/RTAI/linux-2.4.18/include/asm/unistd.h: In function `do_linuxrc':
 /home/nirav/RTAI/linux-2.4.18/include/asm/unistd.h:413: error: asm-specifier for variable `__sc_4' conflicts with asm clobber list
 /home/nirav/RTAI/linux-2.4.18/include/asm/unistd.h:413: error: asm-specifier for variable `__sc_5' conflicts with asm clobber list
 /home/nirav/RTAI/linux-2.4.18/include/asm/unistd.h:412: error: asm-specifier for variable `__sc_4' conflicts with asm clobber list
 /home/nirav/RTAI/linux-2.4.18/include/asm/unistd.h:412: error: asm-specifier for variable `__sc_5' conflicts with asm clobber list
 make: *** [init/main.o] Error 1
 
 
 Thanks and regards
 Nirav
 
 
 
---------------------------------
Food fight? Enjoy some healthy debate
in the Yahoo! Answers Food & Drink Q&A.
--0-574786317-1170594138=:10578
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hello friends greeting all.<br> <br> i am trying to cross compile the linux kernel 2.4.18&nbsp; for powerpc604.( i am using gcc 3.4.1 glibc 2.3.3 binutils 2.15)<br> so i installed the cross tool at /opt/crossool/.....<br> and run following commands<br> [root@nirav linux-2.4.18]# make ARCH=ppc menuconfig&nbsp;&nbsp;&nbsp; <br> [root@nirav linux-2.4.18]# make ARCH=ppc CROSS_COMPILE=powepc-604-linux-gnu- dep zImage<br> and i found following problems. &nbsp;&nbsp;&nbsp;  <br> <br> /home/nirav/RTAI/linux-2.4.18/include/asm/unistd.h:415: warning: conflicting types for built-in function '_exit'<br> /home/nirav/RTAI/linux-2.4.18/include/asm/unistd.h: In function `do_linuxrc':<br> /home/nirav/RTAI/linux-2.4.18/include/asm/unistd.h:413: error: asm-specifier for variable `__sc_4' conflicts with asm clobber list<br> /home/nirav/RTAI/linux-2.4.18/include/asm/unistd.h:413: error: asm-specifier for variable `__sc_5' conflicts with asm clobber list<br>
 /home/nirav/RTAI/linux-2.4.18/include/asm/unistd.h:412: error: asm-specifier for variable `__sc_4' conflicts with asm clobber list<br> /home/nirav/RTAI/linux-2.4.18/include/asm/unistd.h:412: error: asm-specifier for variable `__sc_5' conflicts with asm clobber list<br> make: *** [init/main.o] Error 1<br> <br> <br> Thanks and regards<br> Nirav<br> <br> <p>&#32;

<hr size=1><a href="http://answers.yahoo.com/dir/index;_ylc=X3oDMTFvbGNhMGE3BF9TAzM5NjU0NTEwOARfcwMzOTY1NDUxMDMEc2VjA21haWxfdGFnbGluZQRzbGsDbWFpbF90YWcx?link=ask&sid=396545367">Food fight?</a> Enjoy some healthy debate<br>in the <a href="http://answers.yahoo.com/dir/index;_ylc=X3oDMTFvbGNhMGE3BF9TAzM5NjU0NTEwOARfcwMzOTY1NDUxMDMEc2VjA21haWxfdGFnbGluZQRzbGsDbWFpbF90YWcx?link=ask&sid=396545367">Yahoo! Answers Food & Drink Q&A.</a>
--0-574786317-1170594138=:10578--
