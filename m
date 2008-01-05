Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 43835DDE23
	for <linuxppc-embedded@ozlabs.org>;
	Sun,  6 Jan 2008 01:19:08 +1100 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1JB9rd-0007Dg-2D
	for linuxppc-embedded@ozlabs.org; Sat, 05 Jan 2008 06:19:05 -0800
Message-ID: <14633599.post@talk.nabble.com>
Date: Sat, 5 Jan 2008 06:19:05 -0800 (PST)
From: Misbah khan <misbah_khan@engineer.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Control not branching to the instruction present at resetvec
	i.e 0xfffffffc
In-Reply-To: <OFD408300E.ACB35FD3-ON852573C6.0072065E-852573C6.007337FA@RFLELECT.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <14591717.post@talk.nabble.com> <20080103163019.GA4223@lixom.net>
	<477D2CE0.1050806@kenati.com> <14612548.post@talk.nabble.com>
	<OFD408300E.ACB35FD3-ON852573C6.0072065E-852573C6.007337FA@RFLELECT.COM>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi Mr Ravi ...
I suggest you to post a new concern in a new thread ....

----Misbah 

ravi.rao wrote:
> 
> Hi All,
>     We have a custom target board based on PPC-EP405. We just got the 
> board from the hardware team .I connected the board to BDI200 and powered 
> it on. 
> The control came to the resetvec address which is 0xfffffffc. I was able 
> to read and write to flash. So I erased the flash and burnt the bootloader 
> into flash from 0xfffc0000.
> I verified that the instruction at 0xfffffffc is 4bfc2104 whicis actually 
> a branch to 0xfffc2100. Also a memory dump of 0xfffc2100 shows the correct 
> code. This proved that
> the uboot bootloader was burnt properly.
> Now when I reset the board the control never reaches 0xfffc2100 i.e for 
> some reason the code at the resetvec is not getting executed. Any help or 
> pointers to resolve this is greatly appreciated.
> Thanks,
> Ravishankar Govindarao
> RFL Electronics Inc.
> E-mail : Ravi.Rao@rflelect.com
> Voice: 973.334.3100 Ext. 233
> Fax: 973.334.3863
>  
> CONFIDENTIALITY NOTE
> This e-mail, including any attachments, may contain confidential and/or 
> legally privileged information.  The Information is intended only for the 
> use of the individual or entity named on this e-mail .  If you are not the 
> intended recipient, you are hereby notified that any disclosure, copying, 
> distribution, or the taking of any action in reliance on the contents of 
> this transmitted Information is strictly prohibited.  Further, if you are 
> not the intended recipient, please notify us by return e-mail and delete 
> the Information promptly.
>  
>  
>  
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 

-- 
View this message in context: http://www.nabble.com/Reading-a-config-file-in-a-driver-....-tp14591717p14633599.html
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
