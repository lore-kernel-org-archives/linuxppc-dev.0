Subject: Re: Support for new Dual G4 1 Gig machines?
From: Eric Leblond <eric@regit.org>
To: Christopher Murtagh <christopher.murtagh@mcgill.ca>
Cc: yellowdog-devel@lists.yellowdoglinux.com,
	linuxppc-dev@lists.linuxppc.org
In-Reply-To: <Pine.LNX.4.33.0201281521410.9879-100000@blues.wcg.mcgill.ca>
References: <Pine.LNX.4.33.0201281521410.9879-100000@blues.wcg.mcgill.ca>
Date: 30 Jan 2002 08:00:15 +0100
Message-Id: <1012374015.23794.18.camel@porky>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


le lun 28-01-2002 à 21:34, Christopher Murtagh a écrit :
> On Mon, 28 Jan 2002, Jim Potter wrote:
> >I've been running SMP YDL on a dual 500 for over a year;  it's quite
>  Actually, this depends on what you are doing with the machine. My desktop
> machine is a Dual-450 and it has been running very well. However, I had a
> Dual-800 and a Dual-500 that I tried to put into production, and they both
> crashed often. I had mentioned the 800 to BenH and he suspected a problem


The thing is that I was unable to boot. It hangs at the start at :
	smp_core99_kick_cpu done

Maybe was it a misconfiguration in the OpenFirmware :
when I list the value of the vars in OF, i've got two vars :
	betty_cpu0 passed
	betty_cpu1 ......
Oops, I can't log today on the computer, I don't remember the second
value :-( which was different from the first.
I test it on 2 G4 with exactly the same hardware configuration.

By the way, MacOS 9.2 was highly unstable : it often hangs on netscape.

Cheers,
--
Eric Leblond
Mail: regit@regit.org
Page Linux : http://www-anp.lip6.fr/~leblond/linux/
*---------------------------------------------------------------------------*
 Computers are like air conditioners. They don't work when Windows are
open.
*---------------------------------------------------------------------------*

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
