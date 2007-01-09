Return-Path: <tnt@246tNt.com>
Received: from outmx010.isp.belgacom.be (outmx010.isp.belgacom.be
	[195.238.5.233])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EA203DDE28
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Jan 2007 09:05:02 +1100 (EST)
Received: from outmx010.isp.belgacom.be (localhost [127.0.0.1])
	by outmx010.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id l09M4WPP005707
	for <linuxppc-dev@ozlabs.org>; Tue, 9 Jan 2007 23:04:32 +0100
	(envelope-from <tnt@246tNt.com>)
Message-ID: <45A410F0.3090503@246tNt.com>
Date: Tue, 09 Jan 2007 23:02:24 +0100
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 3/4] powerpc: Use common 52xx of_platform probe code for
	EFIKA
References: <1167776995690-git-send-email-tnt@246tNt.com>	<116777699771-git-send-email-tnt@246tNt.com>	<11677769982640-git-send-email-tnt@246tNt.com>	<11677769981995-git-send-email-tnt@246tNt.com>
	<17827.34251.87306.719371@cargo.ozlabs.ibm.com>
In-Reply-To: <17827.34251.87306.719371@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Linux PPC DEV <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


About the serial patch :

> I didn't put this one in for 2.6.20, because it doesn't solve any
> actual problem, and Ben H tells me it might trigger a bug in the
> generic irq code.

The bug it triggered has been fixed eons ago (like last December 22),
in a impressive one-liner patch that has 5 Signed-off/Acked-by ;) ...

But that code is rarely executed as it would imply the PSC can be
unloaded ... (impossible when used as console). So later merge
is OK.



Paul Mackerras wrote:
> Sylvain Munaut writes:
>
>   
>> Now that the device tree has the good properties, we can
>> remove all the efika_init code by a single call to common code.
>>     
>
> Ummm, but the device tree doesn't have good properties, does it,
> without your patch that adds a whole pile of device tree fixups?
> I'm reluctant to put that in for 2.6.20 because it's moderately large,
> has at least the potential to upset other platforms, and what it fixes
> isn't a regression from 2.6.19, and we're already past -rc4.
>   
Ok, let's just delay everything to the next merge window. Anyway most
the drivers won't get merged until then.

I'll redo a nice patchset with all I got when it opens (or if you open a
for-2.6.21 branch ;).


    Sylvain
