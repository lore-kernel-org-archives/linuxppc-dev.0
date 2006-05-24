Return-Path: <malik_mca2000@yahoo.co.in>
Received: from web8405.mail.in.yahoo.com (web8405.mail.in.yahoo.com
	[202.43.219.153]) by ozlabs.org (Postfix) with SMTP id 938ED67B1E
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 24 May 2006 16:18:48 +1000 (EST)
Message-ID: <20060524061205.53935.qmail@web8405.mail.in.yahoo.com>
Date: Wed, 24 May 2006 07:12:05 +0100 (BST)
From: sandeep malik <malik_mca2000@yahoo.co.in>
Subject: Help Needed: floating point used in kernel (task=c0398410, pc=3184)
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-718617305-1148451125=:53302"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0-718617305-1148451125=:53302
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

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

				
---------------------------------
  Yahoo! India Answers Share what your know-how and wisdom
 Send free SMS to your Friends on Mobile from your Yahoo! Messenger Download now
--0-718617305-1148451125=:53302
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<div>Hi All...</div>  <div>&nbsp;</div>  <div>I am trying to run an application compiled with gcc toolchain&nbsp;gcc--3.4.3 and glibc&nbsp;-2.3.4 on PPC 8325 board running Linux 2.6.11....but some how I am getting following error....</div>  <div class=MsoNormal style="MARGIN: 0in 0in 0pt"><FONT face="Times New Roman" size=3></FONT>&nbsp;</div>  <div class=MsoNormal style="MARGIN: 0in 0in 0pt"><FONT face="Times New Roman" size=3>floating point used in kernel (task=c0398410, pc=3184)</FONT></div>  <div class=MsoNormal style="MARGIN: 0in 0in 0pt"><FONT face="Times New Roman" size=3>floating point used in kernel (task=c0398410, pc=3184)</FONT></div>  <div class=MsoNormal style="MARGIN: 0in 0in 0pt"><FONT face="Times New Roman" size=3>floating point used in kernel (task=c0398410, pc=3184)</FONT></div>  <div class=MsoNormal style="MARGIN: 0in 0in 0pt"><FONT face="Times New Roman" size=3>floating point used in kernel (task=c0398410, pc=3184)</FONT></div>  <div class=MsoNormal
 style="MARGIN: 0in 0in 0pt"><FONT face="Times New Roman" size=3>floating point used in kernel (task=c0398410, pc=3184)</FONT></div>  <div><SPAN style="FONT-SIZE: 12pt; FONT-FAMILY: 'Nimbus Roman No9 L'; mso-bidi-font-size: 10.0pt; mso-fareast-font-family: 'Nimbus Sans L'; mso-bidi-font-family: 'Times New Roman'; mso-ansi-language: EN-US; mso-fareast-language: #00FF; mso-bidi-language: AR-SA"><FONT face="Times New Roman">floating point used in kernel (task=c0398410, pc=3184)</FONT></SPAN></div>  <div><SPAN style="FONT-SIZE: 12pt; FONT-FAMILY: 'Nimbus Roman No9 L'; mso-bidi-font-size: 10.0pt; mso-fareast-font-family: 'Nimbus Sans L'; mso-bidi-font-family: 'Times New Roman'; mso-ansi-language: EN-US; mso-fareast-language: #00FF; mso-bidi-language: AR-SA"><FONT face="Times New Roman"></FONT></SPAN>&nbsp;</div>  <div><SPAN style="FONT-SIZE: 12pt; FONT-FAMILY: 'Nimbus Roman No9 L'; mso-bidi-font-size: 10.0pt; mso-fareast-font-family: 'Nimbus Sans L'; mso-bidi-font-family: 'Times
 New Roman'; mso-ansi-language: EN-US; mso-fareast-language: #00FF; mso-bidi-language: AR-SA"><FONT face="Times New Roman">I was suspecting this error might be because the hardware is not supporting floating point operations and hence i tried&nbsp;</FONT></SPAN><SPAN style="FONT-SIZE: 12pt; FONT-FAMILY: 'Nimbus Roman No9 L'; mso-bidi-font-size: 10.0pt; mso-fareast-font-family: 'Nimbus Sans L'; mso-bidi-font-family: 'Times New Roman'; mso-ansi-language: EN-US; mso-fareast-language: #00FF; mso-bidi-language: AR-SA"><FONT face="Times New Roman">a simple program in which I intentionally did some floating point operation but that program was running as expected. So i concluded that it is not a problem related to floating point operations....I even tried compiling the application with&nbsp;classic ppc compiler(Ver 3.4.3) with&nbsp;-msoft-float option enabled, but still the results were same......</FONT></SPAN></div>  <div><SPAN style="FONT-SIZE: 12pt; FONT-FAMILY: 'Nimbus Roman
 No9 L'; mso-bidi-font-size: 10.0pt; mso-fareast-font-family: 'Nimbus Sans L'; mso-bidi-font-family: 'Times New Roman'; mso-ansi-language: EN-US; mso-fareast-language: #00FF; mso-bidi-language: AR-SA"><FONT face="Times New Roman"></FONT></SPAN>&nbsp;</div>  <div><SPAN style="FONT-SIZE: 12pt; FONT-FAMILY: 'Nimbus Roman No9 L'; mso-bidi-font-size: 10.0pt; mso-fareast-font-family: 'Nimbus Sans L'; mso-bidi-font-family: 'Times New Roman'; mso-ansi-language: EN-US; mso-fareast-language: #00FF; mso-bidi-language: AR-SA"><FONT face="Times New Roman">After these errors i am not able to get control of the system.&nbsp;If anyone who faced this or any such related issue please help me out like what could be probable reason for this error and&nbsp;what all options i have to debug this issue.....</FONT></SPAN></div>  <div><SPAN style="FONT-SIZE: 12pt; FONT-FAMILY: 'Nimbus Roman No9 L'; mso-bidi-font-size: 10.0pt; mso-fareast-font-family: 'Nimbus Sans L'; mso-bidi-font-family: 'Times New
 Roman'; mso-ansi-language: EN-US; mso-fareast-language: #00FF; mso-bidi-language: AR-SA"><FONT face="Times New Roman"></FONT></SPAN>&nbsp;</div>  <div><SPAN style="FONT-SIZE: 12pt; FONT-FAMILY: 'Nimbus Roman No9 L'; mso-bidi-font-size: 10.0pt; mso-fareast-font-family: 'Nimbus Sans L'; mso-bidi-font-family: 'Times New Roman'; mso-ansi-language: EN-US; mso-fareast-language: #00FF; mso-bidi-language: AR-SA"><FONT face="Times New Roman">Thanks &amp; Regards,</FONT></SPAN></div>  <div><SPAN style="FONT-SIZE: 12pt; FONT-FAMILY: 'Nimbus Roman No9 L'; mso-bidi-font-size: 10.0pt; mso-fareast-font-family: 'Nimbus Sans L'; mso-bidi-font-family: 'Times New Roman'; mso-ansi-language: EN-US; mso-fareast-language: #00FF; mso-bidi-language: AR-SA"><FONT face="Times New Roman">Malik</FONT></SPAN></div><p>
	

	
		<hr size=1></hr> 
 <a href="http://us.rd.yahoo.com/mail/in/mailanswersshare/*http://in.answers.yahoo.com/">Yahoo! India Answers</a> Share what your know-how and wisdom<br> 
Send free SMS to your Friends on Mobile from your Yahoo! Messenger <a href="http://us.rd.yahoo.com/mail/in/freesms/*http://messenger.yahoo.com/download.php">Download now</a>
--0-718617305-1148451125=:53302--
