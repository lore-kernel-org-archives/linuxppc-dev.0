Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-07.arcor-online.net (mail-in-07.arcor-online.net
	[151.189.21.47])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A6145DDE10
	for <linuxppc-dev@ozlabs.org>; Tue, 29 May 2007 08:13:57 +1000 (EST)
In-Reply-To: <20070528202822.GA31605@uranus.ravnborg.org>
References: <f7ff5aadda1b2962d6c45123ff944e9af6879306.1179593209.git.segher@kernel.crashing.org>
	<bd3cddd2f3192e3aba4d7c886e38d8d0037c3510.1179593209.git.segher@kernel.crashing.org>
	<20070528202822.GA31605@uranus.ravnborg.org>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <91f430e6615a8895ec0d5293c21f618e@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 2/2] powerpc: Refuse to build 64-bit with GCC-4.2.0 and
	CONFIG_MODULES
Date: Tue, 29 May 2007 00:13:50 +0200
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> ...since this won't work (compiler bug, see 
>> <http://gcc.gnu.org/PR31490>).
>
> Applied both and documented cc-fullversion too.

Thanks!  For reference, where should I have documented this?


Segher
