Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by bilbo.ozlabs.org (Postfix) with ESMTPS id B0BB0B70E5
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 27 Jul 2009 14:35:01 +1000 (EST)
Subject: Re: [PATCH] powerpc: Add compat_sys_truncate
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Chase Douglas <cndougla@linux.vnet.ibm.com>
In-Reply-To: <87B65A66-572B-442E-88C6-872F23DF39D4@linux.vnet.ibm.com>
References: <8349EEAE-34B9-4D7E-837F-1320057E59D2@linux.vnet.ibm.com>
	<1248655033.28464.26.camel@pasglop>
	<87B65A66-572B-442E-88C6-872F23DF39D4@linux.vnet.ibm.com>
Content-Type: text/plain
Date: Mon, 27 Jul 2009 14:34:53 +1000
Message-Id: <1248669293.5706.12.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2009-07-26 at 22:23 -0400, Chase Douglas wrote:
> On Jul 26, 2009, at 8:37 PM, Benjamin Herrenschmidt wrote:
> > Unfortunately, your patch have been mangled by your mailer
> > our your mail gateway in about every possible way (word
> > wrapped, tabs and whitespace damaged etc...)
> 
> Sorry about that! I made sure my mailer (OS X's Mail) sent it as plain  
> text, but I don't know of any settings for specifying line width or  
> white space handling. I'll have to do some more digging or use a  
> different mailer for patches.

I'm sure you can find somebody else using OS X who can help :-)

I've also heard there may be a problem with our vnet servers but
I don't know for sure.

Cheers,
Ben.
