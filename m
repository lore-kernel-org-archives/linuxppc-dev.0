Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B8DC8DDDF3
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 15 Nov 2007 02:44:46 +1100 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1IsKPz-0001nd-Ll
	for linuxppc-embedded@ozlabs.org; Wed, 14 Nov 2007 07:44:43 -0800
Message-ID: <13749163.post@talk.nabble.com>
Date: Wed, 14 Nov 2007 07:44:43 -0800 (PST)
From: alex_snippet <alex.snippet@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Virtex TEMAC 1000Mb/s trouble, but 100b/s is working
In-Reply-To: <13746324.post@talk.nabble.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <13743302.post@talk.nabble.com> <13746324.post@talk.nabble.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi All

Thanks a lot

Trouble solved by adding tcp,no_lock !!!

Regards, Alex
-- 
View this message in context: http://www.nabble.com/Virtex-TEMAC-1000Mb-s-trouble%2C-but-100b-s-is-working-tf4803823.html#a13749163
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
