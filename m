Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0FEAC5F109
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Apr 2009 05:29:31 +1000 (EST)
Message-Id: <C17084D8-19F7-48D2-8E7E-2DE561108A90@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <49E78620.7070303@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: issues w/init
Date: Thu, 16 Apr 2009 14:27:18 -0500
References: <680ABFDC-A67F-48BB-B46C-564CB5373FEB@kernel.crashing.org>
	<88F07543-B7F6-4F27-B5FB-4780AD069D7E@kernel.crashing.org>
	<49E78620.7070303@freescale.com>
Cc: Linuxppc-dev Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 16, 2009, at 2:25 PM, Scott Wood wrote:

> Kumar Gala wrote:
>> [root:~] cat /proc/1/maps
>> 00100000-00103000 r-xp 00100000 00:00 0          [vdso]
>> 0feab000-0ffbe000 r-xp 00000000 00:0d 7127086    /lib/libc-2.2.5.so
>> 0ffbe000-0ffcb000 ---p 00113000 00:0d 7127086    /lib/libc-2.2.5.so
>> 0ffcb000-0ffeb000 rw-p 00110000 00:0d 7127086    /lib/libc-2.2.5.so
>
> IIRC, this libc is old enough to execute out of non-exec memory in  
> some cases.

Yeah, I'm going to that realization.  The question is are we ok with  
breaking older versions of libc like this.

- k
