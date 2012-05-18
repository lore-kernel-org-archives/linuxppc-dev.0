Return-Path: <michael@ellerman.id.au>
Message-ID: <1337327263.20191.6.camel@concordia>
Subject: Re: Re: Build regressions/improvements in v3.4-rc7
From: Michael Ellerman <michael@ellerman.id.au>
To: Timur Tabi <timur@freescale.com>
Date: Fri, 18 May 2012 17:47:43 +1000
In-Reply-To: <4FB546A4.7090502@freescale.com>
References: <1337157034-22773-1-git-send-email-geert@linux-m68k.org>
 <CAMuHMdUtL4_mv-e-EQAZmNcb9dAT=PXB59i7Vuj2vf8NnaBFzQ@mail.gmail.com>
 <1337212281.30558.17.camel@pasglop> <4FB546A4.7090502@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Scott Wood <scottwood@freescale.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>, linux-kernel@vger.kernel.org,
 Linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2012-05-17 at 13:42 -0500, Timur Tabi wrote:
> Benjamin Herrenschmidt wrote:
> >   + arch/powerpc/platforms/512x/mpc512x_shared.c: error: 'enum
> >> fsl_diu_monitor_port' declared inside parameter list [-Werror]:  =>
> >> 70:9, 84:9, 88:36
> >>   + arch/powerpc/platforms/512x/mpc512x_shared.c: error: 'return' with
> >> a value, in function returning void [-Werror]:  => 189:2
> >>   + arch/powerpc/platforms/512x/mpc512x_shared.c: error: function
> >> declaration isn't a prototype [-Werror=strict-prototypes]:  => 69:5,
> >> 88:6, 83:6, 187:1
> >>   + arch/powerpc/platforms/512x/mpc512x_shared.c: error: its scope is
> >> only this definition or declaration, which is probably not what you
> >> want [-Werror]:  => 70:9
> 
> So I think I have a fix for these, but I still would like the actual
> .config so that I can be sure.

I believe it's this one:

http://kisskb.ellerman.id.au/kisskb/buildresult/6312867/config/


cheers
