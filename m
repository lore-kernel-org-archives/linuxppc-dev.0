Date: Thu, 8 Jul 2004 08:20:20 +0200
From: Marc Leeman <marc.leeman@barco.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: rpm for embedded system
Message-ID: <20040708062019.GW12971@smtp.barco.com>
Reply-To: Marc Leeman <marc.leeman@barco.com>
References: <21704-45627@sneakemail.com> <40EC4D3E.5090405@bluewin.ch> <1138-00007@sneakemail.com> <40EC682F.5090004@bluewin.ch> <20685-04823@sneakemail.com> <Pine.LNX.4.60.0407071931460.4395@localhost.localdomain>
Mime-Version: 1.0
In-Reply-To: <Pine.LNX.4.60.0407071931460.4395@localhost.localdomain>
Content-Type: text/plain; charset=iso-8859-15
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> if it's a package that's not part of ELDK, i download the src rpm from
> yellow dog and use ELDK to cross-compile it, then repeat step 1. rpm
> really is overkill for an embedded system.

emdebian is trying to get the crud out of the default gpp debian
packages and provide a nice packet way to compose an embedded system. I
am currently considering this to replace the MVL solution we have now;
especially since they seem to be 'open' (not free, that's not the most
important issue here) on the surface.

I haven't had the time to really investigate the option though, nor have
I found decent documentation for e.g. ppc_82xx builds.

http://www.emdebian.org/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
