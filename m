Message-Id: <5.1.0.14.2.20020807141817.021e7bd8@falcon.si.com>
Date: Wed, 07 Aug 2002 14:29:33 -0400
To: linuxppc-embedded@lists.linuxppc.org
From: Jerry Van Baren <vanbaren_gerald@si.com>
Subject: Re: i2c on mpc824x
In-Reply-To: <3D516125.9636150A@mvista.com>
References: <NCBBIINEHIPFGJPLBEIFKEHMDKAA.acurtis@directvinternet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


The MPC8260 and 824x I2C are definitely different.  Also, I doubt that the
DINK32 implementation is suitable for anything other than an example of how
to use the I2C interface.  The PPCBoot implementation is a hacked together
glue piece that makes the DINK32 pieces sort of work.  Ugly, ugly, ugly.

gvb


At 02:04 PM 8/7/2002 -0400, Mark A. Greer wrote:

>acurtis@directvinternet.com wrote:
>
> > > I noticed that ppcboot has the mpc824x i2c working now. They lifted
> > > Motorola's DINK32 driver and hacked it in.
> > >
> > > Is anyone working to bring mpc824x i2c support to the linux kernel?
>
>Not at this time that I am aware of.
>
> > There is mpc8260 support, is that significantly different?
>
>I believe so.
>
>Mark
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
