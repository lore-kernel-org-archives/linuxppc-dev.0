Subject: Re: ATM driver for 8260 (linux 2.4.x)
From: James Campbell <jcampbell@omnigon.com>
To: linuxppc-embedded@lists.linuxppc.org
Cc: linux-atm-general@lists.sourceforge.net
In-Reply-To: <3C1E205B.C68F12AF@cambridgebroadband.com>
References: <20011215162000.1813.qmail@web9705.mail.yahoo.com>
	<3C1DC1F3.844C7B18@cambridgebroadband.com>
	<1008606453.1383.1.camel@skoll.omnigon.com>
	<3C1E205B.C68F12AF@cambridgebroadband.com>
Content-Type: text/plain
Date: 17 Dec 2001 08:52:02 -0800
Message-Id: <1008607923.1310.3.camel@skoll.omnigon.com>
Mime-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

I'll change it so you can have either the 8260 or the 860 using one
driver, the changes really are not that dramatic.

As far as AAL1 is concerned, the product we are making is very sensitive
to bad data, so QoS is very important to us.  AAL1 at this time is sort
of kludgy, but it works, most of the time. =]  We are using an offshoot
of tornado codes in forward error correcting to just hose a pipe, which
works real well with atm.  Its a patch off ATM 0.78, if anyone is
interested.

Cheers,

James Campbell


On Mon, 2001-12-17 at 08:42, Alex Zeffertt wrote:
>
> Bloody hell, that was quick.
>
> Did you make a lot of changes?  If the answer is no, then maybe you could make it a configuration
> option in arch/ppc/atm/Config.in.  If you can do this in a way that doesn't effect the code when the
> user chooses 860 (as opposed to 8260), I'll put it up on sourceforge CVS.
>
> Alex
>
> PS What do you mean when you say it supports AAL1?  I thought that linux currently only supported
> AAL0 and AAL5.
>
>

--
James Campbell          -|-   Embedded Systems Engineer
jcampbell@omnigon.com   -|-     Omnigon International
pgp:  C138 0E47 5200 40A3 5D09 682E D53F A137 49AE 7171
work: +1.760.804.8884 x 332       cell: +1.760.492.1176
--
"Computer games don't affect kids; I mean if Pac-Man
affected us as kids, we'd all be running around darkened
rooms, munching magic pills and listening to repetitive
electronic music."
         -Kristian Wilson, Nintendo, Inc. 1989


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
