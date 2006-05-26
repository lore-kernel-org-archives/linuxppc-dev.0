Return-Path: <malik_mca2000@yahoo.co.in>
Received: from web8405.mail.in.yahoo.com (web8405.mail.in.yahoo.com
	[202.43.219.153]) by ozlabs.org (Postfix) with SMTP id 8D04767A64
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 26 May 2006 17:45:59 +1000 (EST)
Message-ID: <20060526074557.92475.qmail@web8405.mail.in.yahoo.com>
Date: Fri, 26 May 2006 08:45:56 +0100 (BST)
From: sandeep malik <malik_mca2000@yahoo.co.in>
Subject: RE: Help Needed: floating point used in kernel (task=c0398410,
	pc =3184)
To: linuxppc-embedded@ozlabs.org
In-Reply-To: <9FCDBA58F226D911B202000BDBAD4673026FD914@zch01exm40.ap.freescale.net>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1377189162-1148629556=:92388"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0-1377189162-1148629556=:92388
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

.Hi All...
   
  The problem has been resolved and was no where related to the hardware or software using the floating points....Actually it was associated with wrong linkage....the code was being compiled with gclibc and linked with uClibc....so sometime it was working and sometime it was failing and that too at various different points......
  Thanks everyone for ur help.....
   
  Regards,
  Malik 
  .

Liu Dave-r63238 <DaveLiu@freescale.com> wrote:
  Malik,

Because PPC8325 have NO float point unit, so please compile all of source code with gcc 8325 compiler
or use fixed simulate. The source code includs kernel, and filesystem.

Dave

-----Original Message-----

Hi All...

I am trying to run an application compiled with gcc toolchain gcc--3.4.3 and glibc -2.3.4 on PPC 8325 board running Linux 2.6.11....but some how I am getting following error....

floating point used in kernel (task=c0398410, pc=3184)
floating point used in kernel (task=c0398410, pc=3184)
floating point used in kernel (task=c0398410, pc=3184)
floating point used in kernel (task=c0398410, pc=3184)
floating point used in kernel (task=c0398410, pc=3184)
floating point used in kernel (task=c0398410, pc=3184)

I was suspecting this error might be because the hardware is not supporting floating point operations and hence i tried a simple program in which I intentionally did some floating point operation but that program was running as expected. So i concluded that it is not a problem related to floating point operations....I even tried compiling the application with classic ppc compiler(Ver 3.4.3) with -msoft-float option enabled, but still the results were same......

After these errors i am not able to get control of the system. If anyone who faced this or any such related issue please help me out like what could be probable reason for this error and what all options i have to debug this issue.....

Thanks & Regards,
Malik


Yahoo! India Answers Share what your know-how and wisdom
Send free SMS to your Friends on Mobile from your Yahoo! Messenger Download now


				
---------------------------------
  Yahoo! India Answers Share what your know-how and wisdom
 Send free SMS to your Friends on Mobile from your Yahoo! Messenger Download now
--0-1377189162-1148629556=:92388
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<div>.Hi All...</div>  <div>&nbsp;</div>  <div>The problem has been resolved and was no where related to the hardware or software using the floating points....Actually it was associated with wrong linkage....the code was being compiled with gclibc and linked with uClibc....so sometime it was working and sometime it was failing and that too at various different points......</div>  <div>Thanks everyone for ur help.....</div>  <div>&nbsp;</div>  <div>Regards,</div>  <div>Malik&nbsp;</div>  <div>.<BR><BR><B><I>Liu Dave-r63238 &lt;DaveLiu@freescale.com&gt;</I></B> wrote:</div>  <BLOCKQUOTE class=replbq style="PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #1010ff 2px solid">Malik,<BR><BR>Because PPC8325 have NO float point unit, so please compile all of source code with gcc 8325 compiler<BR>or use fixed simulate. The source code includs kernel, and filesystem.<BR><BR>Dave<BR><BR>-----Original Message-----<BR><BR>Hi All...<BR><BR>I am trying to run an application compiled with
 gcc toolchain gcc--3.4.3 and glibc -2.3.4 on PPC 8325 board running Linux 2.6.11....but some how I am getting following error....<BR><BR>floating point used in kernel (task=c0398410, pc=3184)<BR>floating point used in kernel (task=c0398410, pc=3184)<BR>floating point used in kernel (task=c0398410, pc=3184)<BR>floating point used in kernel (task=c0398410, pc=3184)<BR>floating point used in kernel (task=c0398410, pc=3184)<BR>floating point used in kernel (task=c0398410, pc=3184)<BR><BR>I was suspecting this error might be because the hardware is not supporting floating point operations and hence i tried a simple program in which I intentionally did some floating point operation but that program was running as expected. So i concluded that it is not a problem related to floating point operations....I even tried compiling the application with classic ppc compiler(Ver 3.4.3) with -msoft-float option enabled, but still the results were same......<BR><BR>After these errors i am
 not able to get control of the system. If anyone who faced this or any such related issue please help me out like what could be probable reason for this error and what all options i have to debug this issue.....<BR><BR>Thanks &amp; Regards,<BR>Malik<BR><BR><BR>Yahoo! India Answers Share what your know-how and wisdom<BR>Send free SMS to your Friends on Mobile from your Yahoo! Messenger Download now<BR></BLOCKQUOTE><BR><p>
	

	
		<hr size=1></hr> 
 <a href="http://us.rd.yahoo.com/mail/in/mailanswersshare/*http://in.answers.yahoo.com/">Yahoo! India Answers</a> Share what your know-how and wisdom<br> 
Send free SMS to your Friends on Mobile from your Yahoo! Messenger <a href="http://us.rd.yahoo.com/mail/in/freesms/*http://messenger.yahoo.com/download.php">Download now</a>
--0-1377189162-1148629556=:92388--
