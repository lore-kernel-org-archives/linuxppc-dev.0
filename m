Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D2356DDE2D
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 21 Feb 2007 02:56:36 +1100 (EST)
In-Reply-To: <b4b98b690702200729g389fb77fr488ce2404566ace0@mail.gmail.com>
References: <b4b98b690702200620q3c70cba9j2d8046d4451686a1@mail.gmail.com>
	<002d01c754fd$1f030860$0600000a@waves.com>
	<b4b98b690702200729g389fb77fr488ce2404566ace0@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <4DD2C4C8-908E-415C-A46F-8387E463D622@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: 8541E and vector table.
Date: Tue, 20 Feb 2007 09:55:36 -0600
To: Steve Iribarne (GMail) <netstv@gmail.com>
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Feb 20, 2007, at 9:29 AM, Steve Iribarne (GMail) wrote:

> Hi Ami,
>
> Thanks for the reply.  Yes I have the manual.  I guess I need to be a
> little more specific.  I usually don't get down to this level of the
> hardware.  It usually just works for me.
>
> I have all the explinations etc.. of each vector, but in my memory, I
> can't figure out how to map 0x0000_0700 to one of the SPR's.  I think
> that's what I want to know. :)
>
> -stv

0x700 is most likely Program Check Exception, there isn't a great way  
to do the reverse mapping (addr -> exception) other than looking at  
the code.  You can dump all the IVORs and see which matches if you want.

- k
