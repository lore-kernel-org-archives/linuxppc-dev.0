Message-ID: <3CA4EDA9.5C885292@mvista.com>
Date: Fri, 29 Mar 2002 17:41:45 -0500
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: Michael Sokolov <msokolov@ivan.Harhan.ORG>,
	linux-galileo@source.mvista.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: [Linux-galileo] ev64260 bi_rec patch
References: <0203292359.AA12953@ivan.Harhan.ORG> <3CA4E98B.F7A7ECE0@mvista.com> <3CA4EB1B.91D71401@mvista.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


"Mark A. Greer" wrote:

> "Mark A. Greer" wrote:
>
> > Michael Sokolov wrote:
> >
> > > Because of problem #2 your code will most certainly not work as it is right
> > > now.
> >
> > You may have a point here.  I thought the bi_rec's were left around but I need to
> > verify.
>
> I took a quick look and didn't see it being reused but I may have missed it.

Okay, the bi_recs need to be copied.  Something for you to do over the weekend ;)


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
