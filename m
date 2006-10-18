Return-Path: <randy.dunlap@oracle.com>
Received: from agminet01.oracle.com (agminet01.oracle.com [141.146.126.228])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3DB8867C2A
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Oct 2006 11:23:13 +1000 (EST)
Message-ID: <4535824F.1020407@oracle.com>
Date: Tue, 17 Oct 2006 18:24:31 -0700
From: "Randy.Dunlap" <randy.dunlap@oracle.com>
MIME-Version: 1.0
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 2/2] viocons: make powerpc allmodconfig build
References: <20061017095003.c447d88a.randy.dunlap@oracle.com>
	<20061018111935.a143164c.sfr@canb.auug.org.au>
In-Reply-To: <20061018111935.a143164c.sfr@canb.auug.org.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: ppcdev <linuxppc-dev@ozlabs.org>, paulus <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Stephen Rothwell wrote:
> On Tue, 17 Oct 2006 09:50:03 -0700 Randy Dunlap <randy.dunlap@oracle.com> wrote:
>> From: Randy Dunlap <randy.dunlap@oracle.com>
>>
>> Make allmodconfig .config build successfully by making VIOCONS
>> available only if VT=n.
>> Using PPC_ISERIES in VT prevents kconfig "recursive" warning.
> 
> The problem with this is that we are moving toward being able to build a
> single kernel with PPC_PSERIES and PPC_ISERIES (and others) all defined,
> and this patch will stop Virtual terminal being built in that case.

OK.  Makes sense.  Will you just build VT in that combo *series
config and not build VIOCONS?  If so, that would still fix
"make allmodconfig" to build cleanly (I think).

-- 
~Randy
