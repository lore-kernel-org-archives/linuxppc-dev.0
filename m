Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E2294DDDF3
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  7 Nov 2007 03:46:36 +1100 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1IpRZQ-00058k-Tr
	for linuxppc-embedded@ozlabs.org; Tue, 06 Nov 2007 08:46:32 -0800
Message-ID: <13610744.post@talk.nabble.com>
Date: Tue, 6 Nov 2007 08:46:32 -0800 (PST)
From: khollan <khollan@daktronics.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: serial GDBServer PPC405 problems
In-Reply-To: <fa686aa40711020757y7591ce1eh3902f1856f254e3e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <13532592.post@talk.nabble.com>
	<200711020944.53077.wangbj@lzu.edu.cn>
	<13548781.post@talk.nabble.com>
	<fa686aa40711020757y7591ce1eh3902f1856f254e3e@mail.gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>



Grant Likely-2 wrote:
> 
> 
>> Do I need to add kgdb even if I just want to debug a user application
>> over
>> serial?
> 
> No you don't.  gdbserver is the right tool.
> 
> -- 
> 
> 
So has anyone seen this problem before?
-- 
View this message in context: http://www.nabble.com/serial-GDBServer-PPC405--problems-tf4732593.html#a13610744
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
