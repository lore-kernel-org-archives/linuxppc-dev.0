Return-Path: <s104259@yahoo.it>
Received: from web23107.mail.ird.yahoo.com (web23107.mail.ird.yahoo.com
	[217.146.189.47]) by ozlabs.org (Postfix) with SMTP id B1C9ADDE0D
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 25 Jan 2008 01:27:14 +1100 (EST)
Date: Thu, 24 Jan 2008 15:27:12 +0100 (CET)
From: Angelo <s104259@yahoo.it>
Subject: framebuffer swap endianess
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1829058211-1201184832=:24232"
Message-ID: <217742.24232.qm@web23107.mail.ird.yahoo.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0-1829058211-1201184832=:24232
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hello all, 

many thanks for your answer.

Modify the X server is a good idea.
I'd just tried to understand the exact place to make changes. Adding many "printf" to understand it.
But it's very complex.

>We modified the X Server and swapped when transferring from the shadow
>buffer to the video buffer. That cured all our problems. 

Could you tell me where is the exact place to do this? in some files like fbdev.c or other?

>This was on the 2.4.25 from DENX and with Xfree86.

Sorry but i don't understand this sentence.

Anyway many thanks.


       
---------------------------------

---------------------------------
L'email della prossima generazione? Puoi averla con la nuova Yahoo! Mail
--0-1829058211-1201184832=:24232
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hello all, <br><br>many thanks for your answer.<br><br>Modify the X server is a good idea.<br>I'd just tried to understand the exact place to make changes. Adding many "printf" to understand it.<br>But it's very complex.<br><br>&gt;We modified the X Server and swapped when transferring from the shadow<br>&gt;buffer to the video buffer. That cured all our problems. <br><br>Could you tell me where is the exact place to do this? in some files like fbdev.c or other?<br><br>&gt;This was on the 2.4.25 from DENX and with Xfree86.<br><br>Sorry but i don't understand this sentence.<br><br>Anyway many thanks.<BR><BR><p>&#32;



      <hr size=1><font face="Arial" size="2"><hr size=1><font face="Arial" size="2">L'email della prossima generazione? Puoi averla con la <a href="http://us.rd.yahoo.com/mail/it/taglines/hotmail/nowyoucan/nextgen/*http://it.docs.yahoo.com/nowyoucan.html">nuova Yahoo! Mail</a></font>
--0-1829058211-1201184832=:24232--
