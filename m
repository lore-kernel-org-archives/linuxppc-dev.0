Return-Path: <jwboyer@jdub.homelinux.org>
Received: from jdub.homelinux.org (67-41-71-119.roch.qwest.net [67.41.71.119])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 23CD467A64
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 23 Apr 2005 07:41:26 +1000 (EST)
From: Josh Boyer <jwboyer@jdub.homelinux.org>
To: Jeff.Fellin@rflelect.com
In-Reply-To: <OF6EA2D85F.3FCDDAC2-ON85256FEB.00750EFB@teal.com>
References: <OF6EA2D85F.3FCDDAC2-ON85256FEB.00750EFB@teal.com>
Content-Type: text/plain
Date: Fri, 22 Apr 2005 16:41:27 -0500
Message-Id: <1114206087.27280.4.camel@jdub.homelinux.org>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Flash Statistics
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, 2005-04-22 at 17:19 -0400, Jeff.Fellin@rflelect.com wrote:
> I am looking for information in the kernel or elsewhere about flash usage
> statistics. I'm interested in knowing how
> many times a sector has been erased and written to. This doesn't have to be
> for all time, since other tools
> can erase and write the flash (U-boot), but just what the activity during
> application processing. We use the
> flash to store configuration files that are changeable and would like to
> determine the expected lifetime
> of the chips at use sites.
> 
> Any pointers to places where flash statistics are maintained or tools to
> collect these statistics is
> appreciated.

You might try http://linux-mtd.infradead.org

I'm not aware of any write statistics gathering tools, but MTD is where
they would/should be.

josh
