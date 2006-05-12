Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 11F95679F7
	for <linuxppc-dev@ozlabs.org>; Sat, 13 May 2006 00:02:13 +1000 (EST)
Subject: Re: 2.6 vs 2.4
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Srinivas Murthy <codevana@gmail.com>
In-Reply-To: <1147442231.9412.9.camel@localhost.localdomain>
References: <7cb1293c0605112351y658460a0x8b793ea12004dbfc@mail.gmail.com>
	<1147442231.9412.9.camel@localhost.localdomain>
Content-Type: text/plain
Date: Sat, 13 May 2006 00:02:02 +1000
Message-Id: <1147442522.9412.12.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2006-05-12 at 23:57 +1000, Benjamin Herrenschmidt wrote:
> On Thu, 2006-05-11 at 23:51 -0700, Srinivas Murthy wrote:
> > Hi,
> >  Wolfgang Denk has a good listing of issues to consider betn linux 2.4
> > vs 2.6 for ppc82xx based platforms
> > (http://www.denx.de/wiki/Know/Linux24vs26).
> >  
> >  Would this recommendation still hold?
> >  
> >  Are there any patches, developments in this area?
> 
> The main open question is: is somebody still maintaining the 8xx kernel
> port ?

Oh , and to give a better reply after reading that web page... I'd say
there might be a reason why 2.6 is slower (or appears slower) than 2.4
on some of those embedded platforms. It's definitely faster in a number
of areas on 6xx and other desktop CPUs. A lot of embedded folks will
then bitch and complain about the slowdown on their 8xx processor, but
very few of them if not none popped up actually identifying the actual
issues and coming up with solution for them during the 2.6 dev. cycle.

Ben.
