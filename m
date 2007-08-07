Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DF9AEDDE08
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  8 Aug 2007 06:09:16 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1IIVMf-00052n-SM
	for linuxppc-embedded@ozlabs.org; Tue, 07 Aug 2007 13:09:13 -0700
Message-ID: <12041502.post@talk.nabble.com>
Date: Tue, 7 Aug 2007 13:09:13 -0700 (PDT)
From: khollan <khollan@daktronics.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Telnet on ML410
In-Reply-To: <12039337.post@talk.nabble.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <12039337.post@talk.nabble.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Figured it out I needed to make device nodes 
cd /dev
mknod ptmx c 5 2
cd /dev/pts
mknod 0 c 136 0

-- 
View this message in context: http://www.nabble.com/Telnet-on-ML410-tf4231739.html#a12041502
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
