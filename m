Return-Path: <avorontsov@ru.mvista.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 01F49B72A0
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 20 Jun 2009 01:31:59 +1000 (EST)
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 850E4DDD0C
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Jun 2009 01:31:58 +1000 (EST)
Date: Fri, 19 Jun 2009 19:31:13 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/85xx: Make eSDHC 1-bit only transfer mode
	default for MPC8569E-MDS
Message-ID: <20090619153113.GA6267@oksana.dev.rtsoft.ru>
References: <20090618233752.GA13279@oksana.dev.rtsoft.ru>
	<7898009C-2A9D-45D3-8C2B-1AFA90C4CB31@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <7898009C-2A9D-45D3-8C2B-1AFA90C4CB31@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 18, 2009 at 09:25:46PM -0500, Kumar Gala wrote:
>
> On Jun 18, 2009, at 6:37 PM, Anton Vorontsov wrote:
>
>> For yet unknown reason 4-bit mode doesn't work on MPC8569E-MDS boards,
>> so make 1-bit mode default. When we resolve the issue, u-boot will
>> remove sdhci,1-bit-only property from the device tree, while SDHCI
>> will still work with older u-boots.
>>
>> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
>> ---
>> arch/powerpc/boot/dts/mpc8569mds.dts |    1 +
>> 1 files changed, 1 insertions(+), 0 deletions(-)
>
> Did I miss the patch that adds this property defn. to our docs?

Yep. ;-)

http://lists.ozlabs.org/pipermail/linuxppc-dev/2009-June/073394.html


Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
