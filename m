Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rzCyC6xprzDqdc
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jul 2016 19:49:23 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Alistair Popple <alistair@popple.id.au>, Jiri Slaby <jslaby@suse.com>,
 Samuel Mendoza-Jonas <sam@mendozajonas.com>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH V2 1/2] tty/hvc: Use IRQF_SHARED for OPAL hvc consoles
In-Reply-To: <20160726042814.GA20815@kroah.com>
References: <20160711033858.16172-1-sam@mendozajonas.com>
 <87y458it6n.fsf@@concordia.ellerman.id.au>
 <146950627136.13887.1548506149694212821@concordia>
 <20160726042814.GA20815@kroah.com>
Date: Tue, 26 Jul 2016 19:49:23 +1000
Message-ID: <87shuwybj0.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Greg KH <gregkh@linuxfoundation.org> writes:

> On Tue, Jul 26, 2016 at 02:11:11PM +1000, Michael Ellerman wrote:
>> Quoting Michael Ellerman (2016-07-11 16:29:20)
>> > Greg are you happy to take these two?
>> 
>> I don't see this series anywhere, do you mind if I take them via the
>> powerpc tree for 4.8 ? Or do you want to pick them up.
>
> You can take them, I'm not touching patches now until 4.8-rc1 is out,
> sorry.

No worries, I'll grab them.

cheers
