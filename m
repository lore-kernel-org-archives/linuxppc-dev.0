Return-Path: <benh@kernel.crashing.org>
Subject: Re: PowerMac8600 help ...
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: kevin diggs <diggskevin38@gmail.com>
In-Reply-To: <AANLkTiksY8x7XOifU3FAAPpCa_h4oEBmqu_a0vjRE5h5@mail.gmail.com>
References: <AANLkTiksY8x7XOifU3FAAPpCa_h4oEBmqu_a0vjRE5h5@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 09 Nov 2010 09:31:17 +1100
Message-ID: <1289255477.2147.1368.camel@pasglop>
Mime-Version: 1.0
Cc: Linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2010-11-08 at 10:43 -0600, kevin diggs wrote:
> 
> Sorry for the noise but I am having trouble getting the latest kernel
> built for a PowerMac8600 with a 750GX processor card. If this is not
> an appropriate topic for the list please tell me (and hopefully point
> me in the correct direction).
> 
> I have narrowed the problem down to the compiler. YDL 4.0 is installed
> on the machine. The stock compiler is 3.3.3. That version can NOT
> build past 2.6.28. I built 3.4.6, (the latest 3 series I could find).
> It can NOT build later kernel versions either. It can build Firefox
> 2.0.0.15pre, including powerpc thin lock support. Running it now.
> 
> I then tried 4.3.5. This will build the kernel. But the resulting
> kernel will NOT run. A firefox built with 4.3.5 also will not run. Or
> if it runs it crashes often (http://abcnews.com).
> 
> What really puzzles me is I used the same basic compiler boot
> strapping (3.3.3 to build 3.4.6, 3.4.6 to build 4.3.5) on a GiGE. That
> machine is now running 2.6.36.
> 
> The CFLAGS used were:  "-O2 -mcpu=7450 -mmultiple -mstring" for the
> GiGE (dual 7455s). Substitute 750 for the 8600.
> 
> Any suggestions would be appreciated. 

This is odd... I wonder if your 8600 is having some memory problems ?

Have you tried using the kernel/firefox built with 4.3.5 on the GigE and
booting them on the 8600 ?

3.x are ancient but I would expect 4.3.x to work just fine

Cheers,
Ben.
