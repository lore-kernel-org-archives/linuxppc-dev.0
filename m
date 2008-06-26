Return-Path: <monstr@seznam.cz>
Received: from mxl.seznam.cz (mxl.seznam.cz [77.75.72.44])
	by ozlabs.org (Postfix) with ESMTP id D65BDDE03D
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jun 2008 04:57:47 +1000 (EST)
Message-ID: <4863E70A.2060108@seznam.cz>
Date: Thu, 26 Jun 2008 20:59:22 +0200
From: Michal Simek <monstr@seznam.cz>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: Microblaze init port v4
References: <1214483429-32360-1-git-send-email-monstr@seznam.cz>
	<200806261709.37045.arnd@arndb.de>
In-Reply-To: <200806261709.37045.arnd@arndb.de>
Content-Type: text/plain; charset=ISO-8859-2
Cc: linux-arch@vger.kernel.org, john.williams@petalogix.com,
	vapier.adi@gmail.com, matthew@wil.cx,
	microblaze-uclinux@itee.uq.edu.au, linux-kernel@vger.kernel.org,
	John.Linn@xilinx.com, linuxppc-dev@ozlabs.org,
	will.newton@gmail.com, hpa@zytor.com, drepper@redhat.com,
	alan@lxorguk.ukuu.org.uk
Reply-To: monstr@seznam.cz
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Arnd,

> On Thursday 26 June 2008, monstr@seznam.cz wrote:
>> We have there still problem with syscalls and we don't have chance to 
>> fix it to stable version, this is not part which I can do yourself. 
>> Microblaze will be n + 1 platform which use some old syscalls. 
>> I hope you understand.
> 
> That still leaves the problem that a lot of your syscalls have bugs
> copied from other platforms. If you need to maintain backwards compatibility
> with your existing binaries, that's fine, but please fix the code you are
> adding.

This is for now. I'll remove when I will have new toolchain.

I saw an email from you about.

M
