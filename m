Date: Wed, 24 Apr 2002 08:18:57 -0700
From: andrew may <acmay@acmay.homeip.net>
To: Armin <akuster@pacbell.net>
Cc: andrew may <acmay@acmay.homeip.net>,
	linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: [PATCH] IBM ocp I2C
Message-ID: <20020424081857.B17930@ecam.san.rr.com>
References: <20020423200127.G20394@ecam.san.rr.com> <20020423200151.H20394@ecam.san.rr.com> <3CC63655.1080108@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3CC63655.1080108@pacbell.net>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Apr 23, 2002 at 09:36:37PM -0700, Armin wrote:
> andrew may wrote:
> > On Tue, Apr 23, 2002 at 08:01:27PM -0700, andrew may wrote:
> >
> >>Would anyone be heartbroken if "struct i2c_algo_iic_data" went
> >>away completely?
> >>
> >>In this patch I dump getown and getclock because they aren't
> >>used and I am sure there is a better way to do things.
> >>
> >>Also calculate the I2C div value from the clock rate. I am
> >>not sure if that will work on all 4xx types but it does the
> >>right thing for my 405's.
> >>
> >>I also fixed a few C++ style comments.
> >>
> >>
> > and the patch
> >
>
> Andrew,
>
>
> could you provide a single patch that would be applied on top of the
> *devel.  I appreciate the changes and I will get back to you in on
> "struct i2c_algo_iic_data".  I will need to try the div changes on the
> redwoods (stb03 & stb04 cpus).

This is a single patch, and you should be able to apply it without the
other patches I sent.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
