Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <8D7C5F56B409554D9D46AC22195807F3061D5C@exchwenz01.dmcwave.co.nz>
From: Rod Boyce <rod_boyce@stratexnet.com>
To: 
To: linuxppc-embedded@lists.linuxppc.org
Subject: RE: using bdi2000 to debug ppcboot on mpc7455 
Date: Wed, 1 Oct 2003 10:39:54 +1200 
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Ok so with a bit of tongue and cheek.... To Quote Wolfgang from the 24th of
May 2001...

"Everybody listen: I _will_ mention this trick a 9th  time  for  free. The
10th person asking the same question will owe me a beer."

Does this mean that Q-ha Park owes Wolfgang a beer? ;-)

Rod

> -----Original Message-----
> From: Wolfgang Denk [mailto:wd@denx.de]
> Sent: Wednesday, 1 October 2003 9:35 a.m.
> To: Q-ha Park
> Cc: linuxppc-embedded@lists.linuxppc.org
> Subject: Re: using bdi2000 to debug ppcboot on mpc7455
>
>
> In message <005e01c383f2$65430080$2a21a8c0@qha> you wrote:
> >
> > Thanks a lot for your very informative reply; it helped me greatly and I
> > can finally play with breakpoints. Although I failed to set the
> > breakpoint at after_reloc but the point right before boart_init_r.
>
> For debugging U-Boot / PPCBoot after relocation see
> http://www.denx.de/twiki/bin/view/DULG/DebuggingUBoot#Section_9.1.2.
>
> Best regards,
>
> Wolfgang Denk
>
> --
> Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
> Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
> Heavier than air flying machines are impossible.
>                     -- Lord Kelvin, President, Royal Society, c. 1895
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
