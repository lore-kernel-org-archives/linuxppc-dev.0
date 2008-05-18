Return-Path: <narendra.sisodiya@gmail.com>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.175])
	by ozlabs.org (Postfix) with ESMTP id E19C9DDDF7
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 18 May 2008 15:05:39 +1000 (EST)
Received: by wf-out-1314.google.com with SMTP id 24so899945wfg.15
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 17 May 2008 22:05:38 -0700 (PDT)
Message-ID: <e3fb97f30805172205x65346af9n783e3348c21b18f9@mail.gmail.com>
Date: Sun, 18 May 2008 10:35:38 +0530
From: "narendra sisodiya" <narendra.sisodiya@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: sys/termios.h not found
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_10700_33472498.1211087138279"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_10700_33472498.1211087138279
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

First of all sorry for cross posting this question but i am not getting
answer anywhere. May you can help me,


Dear Sir, I am trying to complie some bluwtooh libraries,

my code has a line which says

# include<termios.h>

which is located at C:\EDK\gnu\microblaze\nt\microblaze\sys-include and its
content is



#ifdef __cplusplus
extern "C" {
#endif
#include <sys/termios.h>
#ifdef __cplusplus
}
#endif

I checked that -- sys directory  which is
C:\EDK\gnu\microblaze\nt\microblaze\sys-include\sys

but this do not contain any file named  termios.h

due to this  i am getting a error in compilation

In file included from lwbt-src/uartif.c:15:
/cygdrive/c/EDK/gnu/microblaze/nt/bin/../lib/gcc/microblaze/3.4.1/../../../../microblaze/sys-include/termios.h:4:25:
sys/termios.h: No such file or directory

 may you help me,

I am also getting a error like

lwbt-src/uartif.c:30: error: storage size of 'oldtio' isn't known
lwbt-src/uartif.c:30: error: storage size of 'newtio' isn't known

 bacause my uartif.c file has

struct termios oldtio, newtio;

 and it is unable to detect the class termios





Thanks n Regards

-- 
Narendra Sisodiya MTech, IIT Delhi

------=_Part_10700_33472498.1211087138279
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<p>First of all sorry for cross posting this question but i am not getting answer anywhere. May you can help me,<br></p><p><br></p><p>Dear Sir, I am trying to complie some bluwtooh libraries,</p><p>my code has a line which says<br>
 </p><p># include&lt;termios.h&gt;&nbsp;</p><p>which is located at C:\EDK\gnu\microblaze\nt\microblaze\sys-include and its content is </p><p>&nbsp; </p><p><font face="courier new,courier">#ifdef __cplusplus<br>extern &quot;C&quot; {<br>
#endif<br>#include &lt;sys/termios.h&gt;<br>#ifdef __cplusplus<br>}<br>#endif</font><br><br> </p><p>I checked that -- sys directory&nbsp; which is C:\EDK\gnu\microblaze\nt\microblaze\sys-include\sys</p><p>but this do not contain any file named&nbsp; <font face="courier new,courier">termios.h</font></p>
<p>due to this&nbsp; i am getting a error in compilation</p><pre>In file included from lwbt-src/uartif.c:15:<br>/cygdrive/c/EDK/gnu/microblaze/nt/bin/../lib/gcc/microblaze/3.4.1/../../../../microblaze/sys-include/termios.h:4:25: sys/termios.h: No such file or directory</pre>
<p>&nbsp;may you help me,</p><p>I am also getting a error like </p><pre>lwbt-src/uartif.c:30: error: storage size of &#39;oldtio&#39; isn&#39;t known<br>lwbt-src/uartif.c:30: error: storage size of &#39;newtio&#39; isn&#39;t known</pre>
<p>&nbsp;bacause my uartif.c file has </p><pre class="fragment"><span class="keyword">struct </span>termios oldtio, newtio;</pre><p>&nbsp;and it is unable to detect the class termios</p><p>&nbsp;</p><p>&nbsp;</p><p>Thanks n Regards<br> </p><br>
-- <br>Narendra Sisodiya MTech, IIT Delhi

------=_Part_10700_33472498.1211087138279--
