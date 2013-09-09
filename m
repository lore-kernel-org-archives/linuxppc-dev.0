Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id E94682C012C
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Sep 2013 20:11:47 +1000 (EST)
Message-ID: <1378721499.11525.5.camel@pasglop>
Subject: Re: [PATCH] powerpc: OE=1 Form Instructions Not Decoded Correctly
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Date: Mon, 09 Sep 2013 20:11:39 +1000
In-Reply-To: <20130908223559.GA495@iris.ozlabs.ibm.com>
References: <CAJ-hshaxuJBMCFquT7J50rjuDYWer_0i1=2QmnOKGAxx4n=FUw@mail.gmail.com>
 <20130908223559.GA495@iris.ozlabs.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Tom Musta <tommusta@gmail.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2013-09-09 at 08:35 +1000, Paul Mackerras wrote:
> 
> Also, you need to indent your code correctly according to
> Documentation/CodingStyle.

Looks like the patch has been mangled by the mailer ... it's in HTML to
begin with :-)

Tom, you need to find a mailer setup that works for sending patches,
basically that sends them in plain text without any mangling of
tabs and spaces and without word wrapping.

I personally use "evolution" under Linux which has a "preformatted"
style mode for that but I'm sure there are plenty of other options.

Cheers,
Ben.
