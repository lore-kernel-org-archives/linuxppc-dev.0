Return-Path: <gqbenjamin@21cn.com>
Received: from 21cn.com (send.forptr.21cn.com [202.105.45.49])
	by ozlabs.org (Postfix) with SMTP id AEA6B681FF
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  9 Sep 2005 00:48:17 +1000 (EST)
Content-Type: text/html
MIME-Version: 1.0
Message-ID: <HZ949091776065.01978@webmail4.inner-21cn.com>
Date: Thu, 8 Sep 2005 22:39:34 +0800 (CST)
From: gqbenjamin@21cn.com
To: zhonglei@RCS-9000.COM
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: How can I compile the module into kernel
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

<P>Wed, 7 Sep 2005 <A href="mailto: zhonglei@RCS-9000.COM">zhonglei@RCS-9000.COM</A>&nbsp;wrote:<BR>&gt;My driver is a char device driver htm.o. How can I compile it into my kernel?<BR>Add your htm.o into the Makefile of char device, and&nbsp;call your driver's init-function in<BR>init-function of char device.&nbsp;<BR><BR>Best Regards,<BR>Benjamin Q. Guo</P>
<P>&nbsp;</P><br><br><a href='http://mail.21cn.com/huodong/0808/index.html' target='_blank'><img src='http://mail.21cn.com/free/sj_mfy_54060.gif' width='540' height='60' border='0'></a><br>
