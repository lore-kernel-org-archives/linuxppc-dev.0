Date: Fri, 7 Jun 2002 13:19:06 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Kevin B. Hendricks" <kevin.hendricks@sympatico.ca>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: can/should we use gcc 3.1 to compile kernels
Message-ID: <20020607201906.GP14252@opus.bloom.county>
References: <200206081337.31359.kevin.hendricks@sympatico.ca> <20020607193833.GO14252@opus.bloom.county> <200206071544.56448.kevin.hendricks@sympatico.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200206071544.56448.kevin.hendricks@sympatico.ca>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Jun 07, 2002 at 03:44:56PM -0400, Kevin B. Hendricks wrote:

> Not too bad warnings-wize excpet for the controlfb.c where it constanly
> gave a funny warning about "pasting ->".

Sounds right.  I think there was a few other things too..

> It did this for every occurence of the macro CNTRL_REG which I must admit
> has two ## which I think gcc was misinterpreting somehow.

Well, isn't:
#define x(foo) a_## foo ##_b
A semi-common thing, like we do in indirect_pci.c ?  Or was it something
different?

> Other than that just the occaissioanal wanring about unused variables and
> things like that.

Lots of the USB stuff uses __FUNCTION__ which gcc-3.1 isn't happy
about.

> I should have saved the build.log

S'alright.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
