Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-03.arcor-online.net (mail-in-03.arcor-online.net
	[151.189.21.43])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 537A0DDF5C
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Mar 2007 22:16:49 +1100 (EST)
In-Reply-To: <20070322004959.GE2295@localhost.localdomain>
References: <4601C8F7.5060006@comcast.net>
	<20070322004959.GE2295@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <ed13d3cfd27edb956a4f3d4bb59a135a@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: libfdt: going forward for u-boot
Date: Thu, 22 Mar 2007 12:16:09 +0100
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> One thought that occurred to me since we last discussed this is to
>> relicense it LGPL.  That way it could be linked into proprietary code
>> without having to maintain a dual license and the copyright assignment
>> headaches that come with outside contributors.
>
> Heh.  The lawyers suggested that too, but I talked them out of it.
> The trouble with LGPL is that to satisfy its conditions you need to be
> pretty careful about how you link things together.

Yeah, the LGPL is even more work for lawyers than the GPL.

You could try a BSD- or MIT-style license perhaps, those
are *really* easy to understand, even to lawyers :-)


Segher
