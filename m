Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id C9A2EDDF55
	for <linuxppc-dev@ozlabs.org>; Sat, 18 Apr 2009 10:41:14 +1000 (EST)
Date: Fri, 17 Apr 2009 20:41:12 -0400
From: Sean MacLennan <smaclennan@pikatech.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>, "linuxppc-dev"
	<linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH] powerpc: Update Warp to use leds-gpio driver
Message-ID: <20090417204112.16834c0a@lappy.seanm.ca>
In-Reply-To: <20090406175825.76bb969c@lappy.seanm.ca>
References: <20090406175825.76bb969c@lappy.seanm.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Any status update on this? The patch has actually been in use since
2.6.29. I wrote a stub LED driver that mimiced leds-gpio with the of
patch.

All I had to do when the leds-gpio of patch went in was drop the stub
driver.

I'd like to get this in then update the warp defconfig for 2.6.30.

Cheers,
   Sean
