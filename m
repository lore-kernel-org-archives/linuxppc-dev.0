Return-Path: <Ravi.Shekhar@Lntemsys.com>
Received: from mail171.messagelabs.com (mail171.messagelabs.com
	[216.82.253.243]) by ozlabs.org (Postfix) with SMTP id 0580AB7B68
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 10 Nov 2009 14:37:56 +1100 (EST)
To: linuxppc-dev@lists.ozlabs.org
Subject: Fw: Help with SPI node
MIME-Version: 1.0
Message-ID: <OF627E4B93.73CDD8FE-ON6525766A.0013CA01-6525766A.0013C6E5@lntemsys.com>
From: Ravi Shekhar <Ravi.Shekhar@Lntemsys.com>
Date: Tue, 10 Nov 2009 09:06:32 +0530
Content-Type: multipart/alternative;
	boundary="=_alternative 0013C6C66525766A_="
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multipart message in MIME format.
--=_alternative 0013C6C66525766A_=
Content-Type: text/plain; charset="US-ASCII"

 I'm attempting to get SPI to work on my embedded design
 that is based on the mpc8313erbd reference board wiht a
 2.6.27 kernel.  I cannot open the SPI device.
 Tracing through the kernel code, it looks like the device is
 not being found in the DTB file.  However there is a
 SPI node in there already described.  Our boards is a
 SPI master, and the device we will attach is a SPI
 slave.  Could someone elaborate on what is needed in
 the DTS file to have our SPI driver work and respond to an
 open() call?


Thanks 
  -Ravi
--=_alternative 0013C6C66525766A_=
Content-Type: text/html; charset="US-ASCII"


<br>
<br><font size=2><tt>&nbsp;I'm attempting to get SPI to work on my embedded
design<br>
&nbsp;that is based on the mpc8313erbd reference board wiht a<br>
&nbsp;2.6.27 kernel. &nbsp;I cannot open the SPI device.<br>
&nbsp;Tracing through the kernel code, it looks like the device is<br>
&nbsp;not being found in the DTB file. &nbsp;However there is a<br>
&nbsp;SPI node in there already described. &nbsp;Our boards is a<br>
 SPI master, and the device we will attach is a SPI<br>
&nbsp;slave. &nbsp;Could someone elaborate on what is needed in<br>
&nbsp;the DTS file to have our SPI driver work and respond to an<br>
&nbsp;open() call?<br>
</tt></font>
<br>
<br><font size=2><tt>Thanks </tt></font>
<br><font size=2><tt>&nbsp; -Ravi</tt></font>
--=_alternative 0013C6C66525766A_=--
