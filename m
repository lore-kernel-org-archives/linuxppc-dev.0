Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B9882DDEE4
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jan 2008 15:31:13 +1100 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1JC67K-0002vp-0T
	for linuxppc-dev@ozlabs.org; Mon, 07 Jan 2008 20:31:10 -0800
Message-ID: <14682271.post@talk.nabble.com>
Date: Mon, 7 Jan 2008 20:31:10 -0800 (PST)
From: Misbah khan <misbah_khan@engineer.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: How to write a device driver in such a fashion .????
In-Reply-To: <14660018.post@talk.nabble.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <14660018.post@talk.nabble.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


using mmap() in application to access the h/w is only possible if  the device
memory is mapped in the kernel virtual memory how come we directly map to
the physical memory to virtual from user space ??? 

----Misbah 

Misbah khan wrote:
> 
> Hi all ....
> 
> I need your suggession to write a driver with such requirements :-
> 
> On Initiation by the application of which key is pressed driver should
> perform the task accordingly. There are 7 keys so seven different task the
> driver will perform. 
> 
> 1 . I do not want to use any entry point such as read/write/ioctl. In such
> a case how to access the driver.
> 2. We dont want to implement this as a chracrter driver.
> 3. The driver shall look pretty much like an application where in
> asscssing the H/W memory map .
> 
> Hence no entry point and no registeration but an application could be able
> to communicate ....
> 
> I need your suggession in this regard .....
> 
> -----Misbah  
> 

-- 
View this message in context: http://www.nabble.com/How-to-write-a-device-driver-in-such-a-fashion-.-----tp14660018p14682271.html
Sent from the linuxppc-dev mailing list archive at Nabble.com.
