Date: Wed, 5 Jun 2002 09:56:31 -0400
From: Bill Fink <billfink@mindspring.com>
To: <acurtis@onz.com>
Cc: linuxppc-dev@lists.linuxppc.org,
	Bill Fink <billfink@mindspring.com>
Subject: Re: Debugging Network Performance
Message-Id: <20020605095631.6f8a03e3.billfink@mindspring.com>
In-Reply-To: <NCBBIINEHIPFGJPLBEIFMECIDIAA.acurtis@onz.com>
References: <20020605011832.63bf4ff5.billfink@mindspring.com>
	<NCBBIINEHIPFGJPLBEIFMECIDIAA.acurtis@onz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 5 Jun 2002, "Allen Curtis" wrote:

> >     "It would be interesting to see where the cpu is being used. Could you
> >     boot with profile=2 and use readprofile to find the worst cpu hogs
> >     during a run?"
>
> Where can I find documentation on the profile=## option? Are there also
> tools that will help to interpret the logs?

Since I didn't actually try it, I don't have a lot more information.
>From /usr/src/linux/Documentation/kernel-parameters.txt:

        profile=        [KNL] enable kernel profiling via /proc/profile
                        (param:log level).

And of course check the readprofile man page.

						-Bill

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
