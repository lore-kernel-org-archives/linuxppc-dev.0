Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 80D48DDE21
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  3 Nov 2007 01:37:29 +1100 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1InxeI-0003iz-It
	for linuxppc-embedded@ozlabs.org; Fri, 02 Nov 2007 07:37:26 -0700
Message-ID: <13548781.post@talk.nabble.com>
Date: Fri, 2 Nov 2007 07:37:26 -0700 (PDT)
From: khollan <khollan@daktronics.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: serial GDBServer PPC405  problems
In-Reply-To: <200711020944.53077.wangbj@lzu.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <13532592.post@talk.nabble.com>
	<200711020944.53077.wangbj@lzu.edu.cn>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>



Wang, Baojun wrote:
> 
> 
> 
> Your kernel don't have kgdb support? then you need a debugger like bdi2000
> to 
> debug the kernel.
> 
> Wang
> 
> 
Do I need to add kgdb even if I just want to debug a user application over
serial?
-- 
View this message in context: http://www.nabble.com/serial-GDBServer-PPC405--problems-tf4732593.html#a13548781
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
