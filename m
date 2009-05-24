Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id A7881DE09E
	for <linuxppc-dev@ozlabs.org>; Mon, 25 May 2009 07:38:57 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1M8LPA-0004Fx-0G
	for linuxppc-dev@ozlabs.org; Sun, 24 May 2009 14:38:52 -0700
Message-ID: <23698384.post@talk.nabble.com>
Date: Sun, 24 May 2009 14:38:52 -0700 (PDT)
From: Mirek23 <miroslaw.dach@psi.ch>
To: linuxppc-dev@ozlabs.org
Subject: U-boot and linux command line parameters
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Dear All,

I use linux kernel 2.6.23 and u-boot 1.2.0 (on ppc405 virtex-4 ) for  some
time. All works fine when the
kernel together with initramfs is smaller than 8MB. If it is bigger than the
kernel does not boot properly.

First of all I would like to know how the address for the linux command line
parameters is "transferred" from u-boot to linux for ppc405 (virtex4 chip)?
(via some registers or is it  a fixed address in the memory ie. 8MB?)
Does somebody know what should be changed, in the kernel,  in order to move
this limitation from 8MB to let say 12MB? I would be grateful for any hint.

Thanks in advance.
M. 
-- 
View this message in context: http://www.nabble.com/U-boot-and-linux-command-line-parameters-tp23698384p23698384.html
Sent from the linuxppc-dev mailing list archive at Nabble.com.
