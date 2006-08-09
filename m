Return-Path: <amodra@bigpond.net.au>
Received: from omta01ps.mx.bigpond.com (omta01ps.mx.bigpond.com
	[144.140.82.153]) by ozlabs.org (Postfix) with ESMTP id 7DF3B67B63
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Aug 2006 23:56:00 +1000 (EST)
Date: Wed, 9 Aug 2006 23:25:30 +0930
From: Alan Modra <amodra@bigpond.net.au>
To: Jonathan Bartlett <johnnyb@eskimo.com>
Subject: Re: .tc entries question
Message-ID: <20060809135530.GD7210@bubble.grove.modra.org>
References: <Pine.SUN.4.58.0607232059070.699@eskimo.com>
	<20060725021558.GG6872@bubble.grove.modra.org>
	<Pine.SUN.4.58.0607250612510.14690@eskimo.com>
	<20060725140634.GH6872@bubble.grove.modra.org>
	<Pine.SUN.4.58.0608090611460.14141@eskimo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.SUN.4.58.0608090611460.14141@eskimo.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Aug 09, 2006 at 06:15:06AM -0700, Jonathan Bartlett wrote:
> Another 64-bit Elf question, this one about the TOC.  In many examples,
> for defining toc entries, there is some syntax like this:
> 
> name_to_refer_to_this:
> .tc seemingly_unused_name[TC], data_here
> 
> I haven't figured out what the purpose of the name immediately preceding
> [TC] is.  In fact, it seems that in most cases it can simply be left out.
> Is this just a holdover from a previous binary format, or does
> "seemingly_unused_name" actually get used in some fashion?

It is just a syntax we inherited from PowerPC64 XCOFF.
seemingly_unused_name and the bracketed class qualifier are completely
ingored.

-- 
Alan Modra
IBM OzLabs - Linux Technology Centre
