Return-Path: <achim.machura@berghof.com>
Received: from mail134.messagelabs.com (mail134.messagelabs.com
	[85.158.137.35]) by ozlabs.org (Postfix) with SMTP id DB49B687DE
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  1 Dec 2005 19:07:34 +1100 (EST)
From: "Achim Machura" <achim.machura@berghof.com>
To: <zengshuai@sogou.com>
Date: Thu, 1 Dec 2005 09:00:41 +0100
Message-ID: <000001c5f64d$538113d0$34f1ff0a@beint.local>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <5100380.1133419921433.JavaMail.postfix@mx3.mail.sohu.com>
Cc: "Linuxppc-Embedded \(E-Mail\)" <linuxppc-embedded@ozlabs.org>
Subject: AW: RE: linuxppc-embedded help needed:kernel access of bad area
Reply-To: achim.machura@berghof.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello,

> #define BCSRADDR 0x04500000
> 
...
> static int PQ2FADS_GPL_open(struct inode *inode,struct file *filp)
> {
> 	PQ2FADS_GPL_CSR=(PQ2FADS_BCSR*)BCSRADDR;

possible you have to change physical address to logical see ioremap.

achim
