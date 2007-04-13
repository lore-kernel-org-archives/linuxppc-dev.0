Return-Path: <matt@genesi-usa.com>
Received: from mail.genesi-usa.com (mithrandir.softwarenexus.net
	[66.98.186.96])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CD838DDE43
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Apr 2007 19:50:32 +1000 (EST)
Message-ID: <461F5275.4060607@genesi-usa.com>
Date: Fri, 13 Apr 2007 10:50:45 +0100
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Olaf Hering <olaf@aepfle.de>
Subject: Re: [PATCH] autodetect serial console on efika
References: <20070331150823.GA25421@aepfle.de>
	<20070412155929.GA28123@aepfle.de>
In-Reply-To: <20070412155929.GA28123@aepfle.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org, Paul Mackeras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

That too :D

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations

Olaf Hering wrote:
> On Sat, Mar 31, Olaf Hering wrote:
> 
>> Efika boards have to be booted with console=ttyPSC0 unless there is a
>> graphics card plugged in. Detect if the firmware stdout is the serial
>> connector.
> 
> Paul, please discard this patch. The optional graphics card may have
> also device_type 'serial' if it is in VGA mode.
> I will send an updated patch later.
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
