Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-05.arcor-online.net (mail-in-05.arcor-online.net
	[151.189.21.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D69D4DDE3C
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Jun 2007 17:55:39 +1000 (EST)
In-Reply-To: <1182822947.5521.145.camel@localhost.localdomain>
References: <20070625105836.GE9768@bakeyournoodle.com>
	<20070625235032.GH9768@bakeyournoodle.com>
	<1182822947.5521.145.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <8f82af2e014b31c41de927623cc25076@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH v2] Fix VDSO gettimeofday() when called with NULL struct
	timeval.
Date: Tue, 26 Jun 2007 09:55:33 +0200
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: LinuxPPC-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> Updated to include feedback from Ben and Segher, also reposition the
>> compare in the 64bit VDSO to catch all the references to tv.
>>
>> From: Tony Breeds <tony@bakeyournoodle.com>
>
> Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Yep fine, thanks Tony.


Segher
