Date: Tue, 4 Sep 2001 17:30:21 +0200
From: Xavier Grave <grave@ipno.in2p3.fr>
To: bwaite@cspi.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: mvme5100 one more time...
Message-ID: <20010904173021.C1530@ipnpcu5.in2p3.fr>
References: <85256ABD.004F8D50.00@pine.cspi.com> <200109041504.LAA27920@orchid.cspi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
In-Reply-To: <200109041504.LAA27920@orchid.cspi.com>; from bwaite@cspi.com on mar, sep 04, 2001 at 16:56:07 +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Shame on me !

I forgot to set the env variable...

After setting it my zImage.pplus give this result :
I have the usual linuxppc/load....

Thanks to every body for your help !

Xavier

Le mar, 04 sep 2001 16:56:07, Brian Waite a écrit :
>
> Make sure you have set this env variable:
> Network PReP-Boot Mode Enable [Y/N] = Y?
>
>
> use env and  accept the defaults for everything else. Once you set Prep
> boot
> mode to Y hit '.' to exit the env variable settings. Make sure you say
> 'Y'
> when it asks you if you want to reset. Then try booting.

--
33 (0) 1 69 15 79 59
De chacun selon ses forces, a chacun selon ses besoins

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
