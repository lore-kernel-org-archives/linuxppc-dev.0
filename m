Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EE5C3DDEDC
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 13 Feb 2008 02:39:43 +1100 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1JOxER-0008Cj-D0
	for linuxppc-embedded@ozlabs.org; Tue, 12 Feb 2008 07:39:39 -0800
Message-ID: <15434487.post@talk.nabble.com>
Date: Tue, 12 Feb 2008 07:39:39 -0800 (PST)
From: IngoM <ingo.maindorfer@ipm.fraunhofer.de>
To: linuxppc-embedded@ozlabs.org
Subject: RE: [Virtex 4 PPC] Problem mountin rootfs via NFS
In-Reply-To: <EE63F03D9E04774997AEBCD21FC77F25190363@ccomm-ex1.ccomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <15355858.post@talk.nabble.com>
	<EE63F03D9E04774997AEBCD21FC77F25190363@ccomm-ex1.ccomm.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi,


Sugathan, Rupesh wrote:
> 
> <snip>
>  
> Do you have a 'console' device file set up in your NFS rootfilesystem? 
> 
> Thanks
> --
> Rupesh Sugathan
> 

you are right. 
I'm adding the device and can login via console.

But some trouble is left:
connected the board via a swich to the PC I loss packets, connectet directly
there are no packets lost.

Any hints?

Best Regards,

Ingo
-- 
View this message in context: http://www.nabble.com/-Virtex-4-PPC--Problem-mountin-rootfs-via-NFS-tp15355858p15434487.html
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
