Return-Path: <dalang@cs.ubc.ca>
Received: from badenpowell.cs.ubc.ca (badenpowell.cs.ubc.ca [142.103.6.71])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4B06A67B46
	for <linuxppc-dev@ozlabs.org>; Sat,  9 Apr 2005 10:37:46 +1000 (EST)
Date: Fri, 8 Apr 2005 17:37:39 -0700 (PDT)
From: Dustin Lang <dalang@cs.ubc.ca>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1113006674.9568.414.camel@gaston>
Message-ID: <Pine.LNX.4.60.0504081736520.26633@bigrock.cs.ubc.ca>
References: <1113006674.9568.414.camel@gaston>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	"debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>
Subject: Re: Sound drivers for newer machines: need help
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hi Ben,

> echo `cat /proc/device-tree/model`
PowerBook6,2

and the second command prints nothing.

Cheers,
dstn.



> Hi !
>
> If you have a newer machine, that is a machine released on or after
> 2002, can you please send me the output of:
>
> echo `cat /proc/device-tree/model`
>
> and
>
> for i in `find /proc/device-tree -name layout-id -print`; do echo $i && hexdump -n4 $i; done
>
> If the later returns nothing, it's fine, just tell me.
>
> I'm especially interested in the various models of G5 based machines. It
> seems apple is having all sorts of very different sound HW setups on
> those machines, and I'm trying to figure out exactly what is where based
> on those infos and the darwin sources.
>
> Ben.
>
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>
