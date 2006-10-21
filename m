Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 9B8DC67BAD
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 22 Oct 2006 09:47:40 +1000 (EST)
To: tran vanle <vantranbk@yahoo.com.au>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: problem when boot new kernel and ramdisk 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Sat, 21 Oct 2006 19:41:14 +1000."
	<20061021094114.40292.qmail@web33012.mail.mud.yahoo.com>
Date: Sun, 22 Oct 2006 01:47:37 +0200
Sender: wd@denx.de
Message-Id: <20061021234737.C0BC8353BDE@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <20061021094114.40292.qmail@web33012.mail.mud.yahoo.com> you wrote:
>
> I have just build kernel image and ramdisk for TQM_8xxL
...
>    Image Name:   Linux-2.6.12-uc0

There is no support for TQM8xxL boards in the context of the 2.6
kernel tree yet. At least, non working support.

> Where error ocur? and how can I fix it ?

Use a 2.4 kernel.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
"Wish not to seem, but to be, the best."                  - Aeschylus
