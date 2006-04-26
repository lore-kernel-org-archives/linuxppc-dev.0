Return-Path: <betatester@orkun.us>
Received: from www65.dixiesys.com (ns65a.dixiesys.com [65.254.42.90])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CACD6679EF
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 27 Apr 2006 09:48:09 +1000 (EST)
Message-ID: <445006B4.2050105@orkun.us>
Date: Wed, 26 Apr 2006 18:48:04 -0500
From: Tolunay Orkun <betatester@orkun.us>
MIME-Version: 1.0
To: Stephen Williams <steve@icarus.com>
Subject: Re: PPC 405GPr support in linux 2.4.32
References: <e2ov5s$1hn$1@sea.gmane.org>
In-Reply-To: <e2ov5s$1hn$1@sea.gmane.org>
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

Stephen Williams wrote:
> ... seems completely missing in the linux-2.3.32 tree from kernel.org.
> This used to be in the linuxppc-2.4 BK tree that no longer exists, so
> what happened to the ppc405GPr support?!

I guess nobody sent patches upstream and development shifted to 2.6 
kernel. 405Gpr is not alone. 405EP and a number of other CPU support 
that was present never got its way up kernel.org sources.
