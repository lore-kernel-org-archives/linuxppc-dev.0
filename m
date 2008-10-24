Return-Path: <CFRIESEN@nortel.com>
Received: from zrtps0kn.nortel.com (zrtps0kn.nortel.com [47.140.192.55])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "", Issuer "NORTEL" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 0DAB8DDDE7
	for <linuxppc-dev@ozlabs.org>; Sat, 25 Oct 2008 09:56:30 +1100 (EST)
Message-ID: <49025275.4050102@nortel.com>
Date: Fri, 24 Oct 2008 16:55:49 -0600
From: "Chris Friesen" <cfriesen@nortel.com>
MIME-Version: 1.0
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 2.6.27-git7 compile error (ppc)
References: <1224265634.15582.3.camel@badari-desktop>
	<1224267073.15582.8.camel@badari-desktop>
	<FEFFA236-AA3B-49F1-AED2-E42950B87BD7@kernel.crashing.org>
	<200810250054.05849.rjw@sisk.pl>
In-Reply-To: <200810250054.05849.rjw@sisk.pl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: LinuxPPC-dev <linuxppc-dev@ozlabs.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Badari Pulavarty <pbadari@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Rafael J. Wysocki wrote:
> On Friday, 17 of October 2008, Kumar Gala wrote:

>> I've got a patch that seems to address this for me building w/ 
>> CONFIG_RELOCATABLE on ppc32/85xx.
> 
> Has that been fixed in 2.6.27 and/or current mainline?

I think CONFIG_RELOCATABLE was introduced post 2.6.27, so shouldn't be a 
problem in that version.

Chris
