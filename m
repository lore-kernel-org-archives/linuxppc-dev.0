Message-ID: <3CC9BD30.7050002@pacbell.net>
Date: Fri, 26 Apr 2002 13:48:48 -0700
From: Armin <akuster@pacbell.net>
MIME-Version: 1.0
To: andrew may <acmay@acmay.homeip.net>
Cc: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: [PATCH] IBM ocp I2C
References: <20020423200127.G20394@ecam.san.rr.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


andrew may wrote:
> Would anyone be heartbroken if "struct i2c_algo_iic_data" went
> away completely?
It might with the us of ocp_driver struct.  still working on it

>
> In this patch I dump getown and getclock because they aren't
> used and I am sure there is a better way to do things.

this does not work on Walnut since "procfreq" is not part of openbios
and the PLLMR does not exsist on the stb03 or 03  so this changes wont
go in.

>
> Also calculate the I2C div value from the clock rate. I am
> not sure if that will work on all 4xx types but it does the
> right thing for my 405's.
>
> I also fixed a few C++ style comments.
  thanks


armin


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
