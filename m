Return-Path: <monstr@seznam.cz>
Received: from mxl.seznam.cz (mxl.seznam.cz [77.75.72.44])
	by ozlabs.org (Postfix) with ESMTP id AC3F1DF694
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jun 2008 04:52:09 +1000 (EST)
Message-ID: <4863E4FD.6040803@seznam.cz>
Date: Thu, 26 Jun 2008 20:50:37 +0200
From: Michal Simek <monstr@seznam.cz>
MIME-Version: 1.0
To: Adrian Bunk <bunk@kernel.org>
Subject: Re: Microblaze init port v4
References: <1214483429-32360-1-git-send-email-monstr@seznam.cz>
	<20080626150121.GB22025@cs181140183.pp.htv.fi>
In-Reply-To: <20080626150121.GB22025@cs181140183.pp.htv.fi>
Content-Type: text/plain; charset=ISO-8859-2
Cc: linux-arch@vger.kernel.org, alan@lxorguk.ukuu.org.uk, vapier.adi@gmail.com,
	arnd@arndb.de, matthew@wil.cx, microblaze-uclinux@itee.uq.edu.au,
	linux-kernel@vger.kernel.org, drepper@redhat.com,
	linuxppc-dev@ozlabs.org, will.newton@gmail.com, hpa@zytor.com,
	John.Linn@xilinx.com, john.williams@petalogix.com
Reply-To: monstr@seznam.cz
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Adrian,

> On Thu, Jun 26, 2008 at 02:29:29PM +0200, monstr@seznam.cz wrote:
>> Hi everybody,
>>
>> current linux version is 2.6.26-rc8 and I think this is the right time
>> to send latest patches againts rc8 for Microblaze CPU.
>> ...
> 
> Thanks for your work on getting the architecture included.
> 
> I have two questions:
> 
> Where can I find a toolchain for compiling a Microblaze kernel?
I personally use petalogix toolchain from www.petalogix.com.

> What is the status of Microblaze support in upstream binutils and gcc?

I don't have any information about. We will discuss with John Williams and guys
from Xilinx
what we can do for it.

M

>> Best regards,
>> Michal Simek
> 
> TIA
> Adrian
> 
> 
> 
> ------------------------------------------------------------------------
> 
> 
> No virus found in this incoming message.
> Checked by AVG. 
> Version: 8.0.101 / Virus Database: 270.4.1/1519 - Release Date: 25.6.2008 04:13
