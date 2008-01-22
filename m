Return-Path: <s104259@yahoo.it>
Received: from web23105.mail.ird.yahoo.com (web23105.mail.ird.yahoo.com
	[217.146.189.45]) by ozlabs.org (Postfix) with SMTP id 128CADDDFE
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 23 Jan 2008 02:53:29 +1100 (EST)
Date: Tue, 22 Jan 2008 16:46:47 +0100 (CET)
From: Angelo <s104259@yahoo.it>
Subject: framebuffer swap endianess
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1484813205-1201016807=:65236"
Message-ID: <323144.65236.qm@web23105.mail.ird.yahoo.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0-1484813205-1201016807=:65236
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi, i'm angelo.

I have just create a framebuffer for an embedded system:
- powerpc (little endian)  with  a GPU (big endian).

I'm working on linux 2.6.22

When i try to execute Xfbdev, it starts but with wrong colors.
I need to swap the RGB format (RRRRRGGGGGGBBBBB) to BGR, respecting the endianess (GGGRRRRRBBBBBGGG).

I know that X loads with some ioctl, the principal settings through framebuffer.
But i'm not sure if framebuffer can inform it on the RGB format.

I also tried to change something on cmap, but nothing changes on display;

So, i hope you can help me. 

Many thanks.


       
---------------------------------

---------------------------------
L'email della prossima generazione? Puoi averla con la nuova Yahoo! Mail
--0-1484813205-1201016807=:65236
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi, i'm angelo.<br><br>I have just create a framebuffer for an embedded system:<br>- powerpc (little endian)&nbsp; with&nbsp; a GPU (big endian).<br><br>I'm working on linux 2.6.22<br><br>When i try to execute Xfbdev, it starts but with wrong colors.<br>I need to swap the RGB format (RRRRRGGGGGGBBBBB) to BGR, respecting the endianess (GGGRRRRRBBBBBGGG).<br><br>I know that X loads with some ioctl, the principal settings through framebuffer.<br>But i'm not sure if framebuffer can inform it on the RGB format.<br><br>I also tried to change something on cmap, but nothing changes on display;<br><br>So, i hope you can help me. <br><br>Many thanks.<BR><BR><p>&#32;



      <hr size=1><font face="Arial" size="2"><hr size=1><font face="Arial" size="2">L'email della prossima generazione? Puoi averla con la <a href="http://us.rd.yahoo.com/mail/it/taglines/hotmail/nowyoucan/nextgen/*http://it.docs.yahoo.com/nowyoucan.html">nuova Yahoo! Mail</a></font>
--0-1484813205-1201016807=:65236--
