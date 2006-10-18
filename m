Return-Path: <randy.dunlap@oracle.com>
Received: from agminet01.oracle.com (agminet01.oracle.com [141.146.126.228])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 182F067C3C
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Oct 2006 13:45:17 +1000 (EST)
Message-ID: <4535A3A3.4000506@oracle.com>
Date: Tue, 17 Oct 2006 20:46:43 -0700
From: "Randy.Dunlap" <randy.dunlap@oracle.com>
MIME-Version: 1.0
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 2/2] viocons: make powerpc allmodconfig build
References: <20061017095003.c447d88a.randy.dunlap@oracle.com>	<20061018111935.a143164c.sfr@canb.auug.org.au>	<4535824F.1020407@oracle.com>
	<20061018133947.20a2c84f.sfr@canb.auug.org.au>
In-Reply-To: <20061018133947.20a2c84f.sfr@canb.auug.org.au>
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
> On Tue, 17 Oct 2006 18:24:31 -0700 "Randy.Dunlap" <randy.dunlap@oracle.com> wrote:
>> OK.  Makes sense.  Will you just build VT in that combo *series
>> config and not build VIOCONS?  If so, that would still fix
>> "make allmodconfig" to build cleanly (I think).
> 
> Yes, VIOCONS is now obsolete (it is replaced by HVC_ISERIES which doesn't
> clash with VT), but it is used by the distros so I don't want to remove
> it (yet).

OK, I wasn't suggesting removing it, just tweaking the dependencies etc.
Is that doable now or do we wait for the integrated I/P series configs?

-- 
~Randy
