Message-ID: <3AE919BA.950AACA@motorola.com>
Date: Fri, 27 Apr 2001 08:03:22 +0100
From: "John Traill" <john.traill@motorola.com>
MIME-Version: 1.0
To: Dan Malek <dan@mvista.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: 8260 SCC as Console
References: <3AE859E4.8CF5063A@mvista.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan,

I should have been more specific - Do you have a patch for the ADS8260 ?


Dan Malek wrote:
>
> John Traill wrote:
> >
> > Does anyone have a patch ( Or is working on one ) to use an SCC as a console ?
>
> Yes.  The linuxppc_2_5 kernel has all of the right pieces.  I have
> since made some changes that allow this to be selected as a configuration
> option, and the patches are in the pipeline back to the FSM Labs trees.
>
> When using the SCC Console, the driver doesn't support SMC serial
> ports due to some configuration conflicts I haven't yet resolved.
> So far, I haven't seen hardware that uses an SCC console and SMC serial
> ports, which places fixing this rather low on my list.
>
> What board are you working on?  I have a Linux port for the ADS8260.....
>
>         -- Dan
>

--

Regards, John
___________________________________________________________________________

John Traill                                   Motorola
Ph.   : +44 (0)1355 355494                    Colvilles Road
Fax.  : +44 (0)1355 261790                    East Kilbride G75 OTG
email : johnt@burton.sps.mot.com              Scotland
      : R17296@email.sps.mot.com

[x] General Business Use
[ ] Motorola Internal Use Only
[ ] Motorola Confidential Proprietary

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
