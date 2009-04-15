Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 4CB7FDE0D1
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Apr 2009 03:54:48 +1000 (EST)
Date: Wed, 15 Apr 2009 21:54:47 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/85xx: Add P2020DS board support
Message-ID: <20090415175447.GA17134@oksana.dev.rtsoft.ru>
References: <1239810564-8403-1-git-send-email-galak@kernel.crashing.org>
	<20090415165009.GA10214@oksana.dev.rtsoft.ru>
	<5F3E22A9-AC7D-4066-B861-C98755BAE4A8@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <5F3E22A9-AC7D-4066-B861-C98755BAE4A8@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Ted Peters <ted.peters@freescale.com>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Apr 15, 2009 at 12:22:48PM -0500, Kumar Gala wrote:
>
> On Apr 15, 2009, at 11:50 AM, Anton Vorontsov wrote:
>
>>
>> Sorry for bringing this up again... But can we decide on soc's
>> compatible scheme and finally remove the device_type = "soc"
>> for new boards? "fsl,p2020-soc", "fsl,soc", "simple-bus" maybe?
>>
>> Thanks,
>
> We can, but I don't want to couple the two issues. If someone wants to 
> work and post patches related to this issue I'm all for it.

I posted it in 2008:

http://www.mail-archive.com/linuxppc-dev@ozlabs.org/msg14311.html

Do we agree on "fsl,<cpu>-{immr,ccsr}", "fsl,{immr,ccsr}", "fsl,soc",
"simple-bus"?

IIRC you didn't like "fsl,soc" in general and asked for more
discussion:

http://ozlabs.org/pipermail/linuxppc-dev/2008-January/050753.html

And from time to time I'm just trying to provoke this discussion.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
