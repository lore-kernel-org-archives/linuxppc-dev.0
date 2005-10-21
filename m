Return-Path: <nathael.pajani@cpe.fr>
Received: from smtp-out.completel.net (smtp-out.completel.net [83.145.110.35])
	by ozlabs.org (Postfix) with ESMTP id 2598868651
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 22 Oct 2005 02:03:30 +1000 (EST)
Received: from [192.52.109.152] (unknown [83.145.98.3])
	by smtp-out.completel.net (Postfix) with ESMTP id 8307825C05D
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 21 Oct 2005 18:03:25 +0200 (CEST)
Message-ID: <435911B6.9070600@cpe.fr>
Date: Fri, 21 Oct 2005 18:05:10 +0200
From: Nathael PAJANI <nathael.pajani@cpe.fr>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: Three-Speed Ethernet support on MPC8560 (TSEC)
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:

 >> I will now go on with the Three-Speed Ethernet Controler, and there
 >> actually seem to be no support for it, but maybe I did not look at
 >> the right place?
 >
 >
 > The TSEC has been supported for a long time.  The driver is call
 > gianfar (drivers/net/gianfar*).
 >

OK, I found it, and remembered that at the begining of the port I 
wondered what the "struct platform_device ppc_sys_platform_devices[]" 
was for, now I know. and I'll try this for the FCC3 too.

There is a problem though, which I already had (and fixed) with the 
boot-loader: The gigabit ethernet is not set up correctly: Everything is 
fine with a Gigabit switch, but with a Fast ethernet switch there is no 
communication.
I'll look for this on monday!

Thanks a lot for the help !
