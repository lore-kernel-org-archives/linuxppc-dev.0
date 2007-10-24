Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (unknown [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 8D1F4DDF22
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Oct 2007 06:12:22 +1000 (EST)
Date: Wed, 24 Oct 2007 15:19:32 -0500
From: Olof Johansson <olof@lixom.net>
To: Tony Breeds <tony@bakeyournoodle.com>
Subject: Re: New time code miscalculates cpu usage
Message-ID: <20071024201932.GA29542@lixom.net>
References: <20071016202525.GA11837@lixom.net>
	<20071017060747.GF9814@bakeyournoodle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071017060747.GF9814@bakeyournoodle.com>
Cc: paulus@samba.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Oct 17, 2007 at 04:07:48PM +1000, Tony Breeds wrote:
> On Tue, Oct 16, 2007 at 03:25:25PM -0500, Olof Johansson wrote:
> > Hi,
> > 
> > Not sure when this started happening, but I wanted to report it. I'll
> > start bisecting in a day or two if noone else has gotten around to
> > looking at it:
> > 
> > $ echo "int main(void) { while(1); }" > test.c ; gcc test.c
> > $ time ./a.out & sleep 2 ; killall a.out
> > real    0m2.008s
> > user    0m4.014s
> > sys     0m0.002s
> > 
> > Seen on POWER5 and PA6T, haven't tried anything else yet.
> 
> For what it's worth, this is my bug.  I suspected it, and git bisect
> confirmed it.I have an ugly work around now, but hope to have something
> better out tomorrow.

Hi Tony,

Any news?


-Olof
