Subject: Re: ppc405 floating point emulation
From: Toni Van Remortel <t.vanremortel@ha.be>
Reply-To: t.vanremortel@ha.be
To: Jon Masters <jonathan@jonmasters.org>
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <3FC4BACC.6000606@jonmasters.org>
References: <3FC4BACC.6000606@jonmasters.org>
Content-Type: text/plain
Message-Id: <1070009213.4140.9.camel@toni>
Mime-Version: 1.0
Date: Fri, 28 Nov 2003 09:46:53 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Op wo 26-11-2003, om 15:38 schreef Jon Masters:
> Hi there,
>
> Can someone tell me what they think the status of the mathemu on ppc405
> currently is? I am faced with a situation in which we will probably
> require some kind of library or kernel emulation support and all around
> people suggest not to even go there :-).

That's what they told me too, but I did go there. And the result is
still quite good.
I'm currently writing the last documentation on our laser-projector.
This projects figures which are calculated by sin and cos together with
a pow function. Off course, we used lookup-tables and approx-functions,
but it works pretty well. Yesterday was the big show of it, and most
people liked it.

Anyhow, I use it in combination with real-time, and you cannot rely on
float calculations then. So you need a good implementation to get full
result of it.

Calculation isn't very fast, but on half a second, my module calculates
360 X and Y coordinates with 2 sin, 2 cos and 3 pow functions each
point.

So it is possible to use softfloat, but you MUST know that you cannot
rely on speed then. So far my small experience with it :)

PS: next week, I hope the docs will be ready and available on my website
under 'cases'/'our case'.

Regards,
--
                           Toni Van Remortel
              Wetenschappelijk Medewerker - D-science lab
  Real time Linux for embedded systems: http://linemb.d-sciencelab.com
              Tel: +32 3 205 61 72 - Fax: +32 3 205 61 95
                      E-mail: t.vanremortel@ha.be


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
