Date: Wed, 24 Apr 2002 11:21:12 -0700
From: Matt Porter <mporter@mvista.com>
To: andrew may <acmay@acmay.homeip.net>
Cc: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Status on 405GP i2c driver
Message-ID: <20020424182111.GI11949@beef.az.mvista.com>
References: <20020422141601.B16319@ecam.san.rr.com> <20020423160548.A5009@home.com> <20020423182301.B19665@ecam.san.rr.com> <20020424144733.GA11949@beef.az.mvista.com> <20020424083909.C17930@ecam.san.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020424083909.C17930@ecam.san.rr.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Apr 24, 2002 at 08:39:09AM -0700, andrew may wrote:
> On Wed, Apr 24, 2002 at 07:47:33AM -0700, Matt Porter wrote:
> > It's not a good idea to merge the i2c-2.6.3 support into 2_4_devel.
>
> It seemed that Armins patch to the i2c list was against 2.6.3 so I deciede
> to merge that in before I merged in Armin's patch. I started doing the merge
> before you added in the files so that made things interesting. Unless you
> think 2.6.3 has some new bugs I see no reason to back out the changes in
> my tree.
>
> > The idea here is to make available a 4xx IIC driver that can be used
> > with the current i2c infrastructure in the 2.4 kernel and can be
> > changed in sync with any ocp changes that are made.
>
> I will try to make sure that my patches don't class with any of the core
> i2c stuff.
>
> My idea for posting the patches was just to show what I did in my tree,
> at this point we should be insync in terms of the actual ibm_ocp drivers.

Gotcha now...I thought you were indicating a desire to have all the
i2c-2.6.3 core stuff in your first patches added to 2_4_devel.

Thanks,
--
Matt Porter
MontaVista Software, Inc.
mporter@mvista.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
