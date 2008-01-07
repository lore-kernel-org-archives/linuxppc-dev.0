Return-Path: <Clive.Jenkins@xerox.com>
Received: from wvmler3.mail.xerox.com (wvmler3.mail.xerox.com [13.8.138.218])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wvmler3.mail.xerox.com",
	Issuer "wvmler3.mail.xerox.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id C1656DDE04
	for <linuxppc-dev@ozlabs.org>; Mon,  7 Jan 2008 22:14:03 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: How to write a device driver in such a fashion .????
Date: Mon, 7 Jan 2008 10:55:26 -0000
Message-ID: <35786B99AB3FDC45A82157246179197301356569@gbrwgceumf01.eu.xerox.net>
In-Reply-To: <14660018.post@talk.nabble.com>
From: "Jenkins, Clive" <Clive.Jenkins@xerox.com>
To: "Misbah khan" <misbah_khan@engineer.com>, <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

=20
> On Initiation by the application of which key is pressed
> driver should perform the task accordingly. There are 7
> keys so seven different task the driver will perform.=20

This is not clear to me.

> 1 . I do not want to use any entry point such as
> read/write/ioctl. In such a case how to access the driver.
> 2. We dont want to implement this as a chracrter driver.
> 3. The driver shall look pretty much like an application
> where in asscssing the H/W memory map .
>
> Hence no entry point and no registeration but an
> application could be able to communicate ....

I think you want the application to directly access
memory-mapped hardware. For this you will need to open
/dev/mem and use the mmap() system call to get a virtual
address of your h/w.

Clive
