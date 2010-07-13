Return-Path: <martyn.welch@ge.com>
Received: from exprod5og105.obsmtp.com (exprod5og105.obsmtp.com [64.18.0.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3979AB6F11
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 13 Jul 2010 20:36:38 +1000 (EST)
Message-ID: <4C3C4175.40005@ge.com>
Date: Tue, 13 Jul 2010 11:35:33 +0100
From: Martyn Welch <martyn.welch@ge.com>
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] powerpc: reduce the size of the defconfigs
References: <20100713170945.26d95641.sfr@canb.auug.org.au>
	<20100713073137.GC26442@pengutronix.de>
In-Reply-To: <20100713073137.GC26442@pengutronix.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Olof Johansson <olof@lixom.net>, Stephen Rothwell <sfr@canb.auug.org.au>,
	Linus <torvalds@linux-foundation.org>,
	ppc-dev <linuxppc-dev@lists.ozlabs.org>,
	LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Uwe Kleine-König wrote:
> On Tue, Jul 13, 2010 at 05:09:45PM +1000, Stephen Rothwell wrote:
>   
>> This uses Uwe's script (modified by Olof Johansson to speed it up
>> somewhat) to reduce the size of all the powerpc defconfigs.  The resulting
>>     
> IMHO we should add the script to the source, too.  And if it's only for
> me to see Olof's optimisation. :-)
>
>   

As the person who introduced the gef_* PPC defconfigs to the kernel (I
understood this to be best practice), I'm happy to go along with
whatever - as long as I can build a bootable kernel from the mainline
kernel. I think I understand Linus' wish not to see all the defconfig
churn (I get fed up diffing defconfigs, just to read through loads of
additions and removals of undef'ed entires from just the few configs I'm
interested in).

I assume I'm not alone among those attempting to add board support to
the mainline kernel in not being able to keep up with the LKML mailing
list and therefore have missed most of this discussion (think I've
managed to read some of it now). I would very much appreciate some
documentation / guidance on how to use this script - preferably provided
as a comment in the head of the script or/and some pointers in
"Documentation/".

Martyn

>> files have been verified to produce the same .config files by generating
>> them before and after this patch and comparing the results.
>>
>> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
>> ---
>>  100 files changed, 51 insertions(+), 133815 deletions(-)
>>     
> Nice.
>
> Best regards
> Uwe
>
>   


-- 
Martyn Welch (Principal Software Engineer)   |   Registered in England and
GE Intelligent Platforms                     |   Wales (3828642) at 100
T +44(0)127322748                            |   Barbirolli Square, Manchester,
E martyn.welch@ge.com                        |   M2 3AB  VAT:GB 927559189
