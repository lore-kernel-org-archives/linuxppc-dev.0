Message-Id: <200109041504.LAA27920@orchid.cspi.com>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Brian Waite <bwaite@cspi.com>
Reply-To: bwaite@cspi.com
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: mvme5100 one more time...
Date: Tue, 4 Sep 2001 10:56:07 -0400
References: <85256ABD.004F8D50.00@pine.cspi.com>
In-Reply-To: <85256ABD.004F8D50.00@pine.cspi.com>
MIME-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Make sure you have set this env variable:
Network PReP-Boot Mode Enable [Y/N] = Y?


use env and  accept the defaults for everything else. Once you set Prep boot
mode to Y hit '.' to exit the env variable settings. Make sure you say 'Y'
when it asks you if you want to reset. Then try booting.


Thanks
Brian


On Tuesday 04 September 2001 10:28 am, you wrote:
> Le mar, 04 sep 2001 16:06:59, Brian Waite a
> écrit :
> > Xavier,
> >    Just a quick sanity check, are all the jumpers at factory default
> > and have
> > you changed any env settings? Just a thought.
>
> Hi Brian,
>
> I don't have change any jumper or env variables.
> Do I need to do so to boot with a tftp server ?
>
> Thanks for your hint.
>
> Xavier

--
Brian Waite

Looking for a TeraFLOP in a closet
www.fastcluster.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
