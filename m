Return-Path: <adams.ppc@gmail.com>
Received: from mail-gx0-f21.google.com (mail-gx0-f21.google.com
	[209.85.217.21]) by ozlabs.org (Postfix) with ESMTP id 191E0DE171
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 18 Sep 2008 05:13:17 +1000 (EST)
Received: by gxk14 with SMTP id 14so28054163gxk.9
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 17 Sep 2008 12:13:10 -0700 (PDT)
Message-ID: <4a21eaea0809171213o2218c4aau222f36e1c5575f78@mail.gmail.com>
Date: Wed, 17 Sep 2008 13:13:09 -0600
From: "bhanu jampala" <adams.ppc@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: Covert DMA address to Virtual address on Linux PPC
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_11371_17280650.1221678789945"
Cc: rmcguire@videopresence.com, "M. Warner Losh" <imp@bsdimp.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_11371_17280650.1221678789945
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi All,

How do I convert a DMA buffer address to its respective virtual address in
Linux PPC world?

I am not finding appropriate functions to do that?
How are people doing it on PPC platforms?

What I trying to do:
This is for MCC i.e. Buffer Desc and buffer are in main memory (DMA memory)
I have submitted some DMA buffer from a chunk of memory to Device.
Now at the end of successful receive, where I know the DMA address by
reading from the buffer Descriptors.
Now from this DMA address, how do I find out the Virtual address so that I
can perform a read on that buffer?

Regards,
Mukund Jampala

------=_Part_11371_17280650.1221678789945
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div dir="ltr">Hi All,<br><br>How do I convert a DMA buffer address to its respective virtual address in Linux PPC world?<br><br>I am not finding appropriate functions to do that?<br>How are people doing it on PPC platforms?<br>

<br>What I trying to do:<br>This is for MCC i.e. Buffer Desc and buffer are in main memory (DMA memory)<br>
I have submitted some DMA buffer from a chunk of memory to Device.<br>
Now at the end of successful receive, where I know the DMA address by reading from the buffer Descriptors.<br>Now from this DMA address, how do I find out the Virtual address so that I can perform a read on that buffer?<br>

<br>Regards,<br>Mukund Jampala</div>

------=_Part_11371_17280650.1221678789945--
