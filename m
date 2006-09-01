Return-Path: <carlos@kenati.com>
Received: from mail.kenati.com (unknown [69.90.147.196])
	by ozlabs.org (Postfix) with ESMTP id 1E89E67B78
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  2 Sep 2006 03:03:55 +1000 (EST)
Message-ID: <44F862F3.9020404@kenati.com>
Date: Fri, 01 Sep 2006 09:42:27 -0700
From: Carlos Munoz <carlos@kenati.com>
MIME-Version: 1.0
To: "Matias Sundman (AS/EAB)" <matias.sundman@ericsson.com>
Subject: Re: Backtrace
References: <24521B9781EAC745A4BE65966F69C9BE02BACDA8@esealmw115.eemea.ericsson.se>
In-Reply-To: <24521B9781EAC745A4BE65966F69C9BE02BACDA8@esealmw115.eemea.ericsson.se>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Matias Sundman (AS/EAB) wrote:

> Comrades,
> I would like to do a backtrace in kernel space similar to an oops but 
> then continue the code flow as before i.e. without a crash.
>
Try dump_stack(). It should do what you want.


Carlos
