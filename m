Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 21566B7080
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 11 Jul 2009 02:36:55 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 58194DDDF0
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Jul 2009 02:36:54 +1000 (EST)
Message-Id: <D2ADC85F-2986-42EA-B8AD-03F30E871A55@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: "Ira W. Snyder" <iws@ovro.caltech.edu>
In-Reply-To: <20090710150420.GA11719@ovro.caltech.edu>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v935.3)
Subject: Re: [PATCH v2] edac: mpc85xx: add support for mpc83xx memory
	controller
Date: Fri, 10 Jul 2009 10:36:20 -0500
References: <2576.44687.qm@web50111.mail.re2.yahoo.com>
	<20090710150420.GA11719@ovro.caltech.edu>
Cc: linuxppc-dev@ozlabs.org, Doug Thompson <norsk5@yahoo.com>,
	bluesmoke-devel@lists.sourceforge.net, Dave Jiang <djiang@mvista.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jul 10, 2009, at 10:04 AM, Ira W. Snyder wrote:

> On Thu, Jul 09, 2009 at 04:24:38PM -0700, Doug Thompson wrote:
>>
>> Ok, is this the one you want me to push upstream?
>>
>
> Yep, this is the finished version.
>
> Thanks,
> Ira
>
>> doug t
>

is that for .31 or .32?  If .31 I'm fine.  If for .32 I still have  
some things I like to deal with.  (like the other 85xx specific bits)

- k
