Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 733F5DDEC1
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  9 Feb 2008 06:01:02 +1100 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1JNYT5-0001TO-Aa
	for linuxppc-embedded@ozlabs.org; Fri, 08 Feb 2008 11:00:59 -0800
Message-ID: <15361890.post@talk.nabble.com>
Date: Fri, 8 Feb 2008 11:00:59 -0800 (PST)
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


Dear Rupesh,


Sugathan, Rupesh wrote:
> 
> 
> <snip>
> 
>  
> Do you have a 'console' device file set up in your NFS rootfilesystem? 
> 
> 

no, I don't think so. When I'm back in office Monday morning I'll looking
into detail for you.
But the error seems to be some low-level network issue: sometimes kernel can
mount NFS, sometimes not and so on.

Best Regards, 

Ingo

-- 
View this message in context: http://www.nabble.com/-Virtex-4-PPC--Problem-mountin-rootfs-via-NFS-tp15355858p15361890.html
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
