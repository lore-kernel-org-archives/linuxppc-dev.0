Return-Path: <iws@ovro.caltech.edu>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id BE78BB7081
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 11 Jul 2009 03:17:17 +1000 (EST)
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	by ozlabs.org (Postfix) with ESMTP id BE0F9DDD1C
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Jul 2009 03:17:15 +1000 (EST)
Date: Fri, 10 Jul 2009 10:17:12 -0700
From: "Ira W. Snyder" <iws@ovro.caltech.edu>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v2] edac: mpc85xx: add support for mpc83xx memory
	controller
Message-ID: <20090710171711.GC11719@ovro.caltech.edu>
References: <2576.44687.qm@web50111.mail.re2.yahoo.com>
	<20090710150420.GA11719@ovro.caltech.edu>
	<D2ADC85F-2986-42EA-B8AD-03F30E871A55@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <D2ADC85F-2986-42EA-B8AD-03F30E871A55@kernel.crashing.org>
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

On Fri, Jul 10, 2009 at 10:36:20AM -0500, Kumar Gala wrote:
>
> On Jul 10, 2009, at 10:04 AM, Ira W. Snyder wrote:
>
>> On Thu, Jul 09, 2009 at 04:24:38PM -0700, Doug Thompson wrote:
>>>
>>> Ok, is this the one you want me to push upstream?
>>>
>>
>> Yep, this is the finished version.
>>
>> Thanks,
>> Ira
>>
>>> doug t
>>
>
> is that for .31 or .32?  If .31 I'm fine.  If for .32 I still have some 
> things I like to deal with.  (like the other 85xx specific bits)
>

.32 is fine for me. This is a new feature, not really a bugfix. I can
maintain it in my (growing) set of patches against mainline until it
gets merged.

Ira
