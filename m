To: "Michel =?iso-8859-1?q?D=E4nzer?=" <michdaen@iiic.ethz.ch>
Cc: "Jason E. Stewart" <jason@openinformatics.com>,
	debian-powerpc@lists.debian.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: Success! (was Re: External Monitor under Pismo)
References: <20010404092143.EFE4C2F01B@apollo.valhalla.net>
	<3ACB537B.99B851B9@netfall.com>
	<87hf0433qs.fsf@amadeus.openinformatics.com>
	<3ACB6167.3B2E0242@iiic.ethz.ch>
	<878zlg31mw.fsf@amadeus.openinformatics.com>
	<3ACB9611.C95D16A2@iiic.ethz.ch>
	<87ae5w1ce3.fsf@amadeus.openinformatics.com>
	<3ACB9EB3.2661FFCE@iiic.ethz.ch>
	<87u242zz7y.fsf@amadeus.openinformatics.com>
	<3ACCFFBB.58CC75D2@iiic.ethz.ch>
	<87itjmf7lf.fsf_-_@amadeus.openinformatics.com>
	<3AEDEF2D.4B823134@iiic.ethz.ch>
	<87wv7x984o.fsf@amadeus.openinformatics.com>
	<3AF1D91F.7030801@iiic.ethz.ch>
	<87hez1pjm1.fsf@amadeus.openinformatics.com>
	<3AF29AF6.9AC80F3E@iiic.ethz.ch>
From: jason@openinformatics.com (Jason E. Stewart)
Date: 04 May 2001 11:14:28 -0600
In-Reply-To: <3AF29AF6.9AC80F3E@iiic.ethz.ch>
Message-ID: <87hez1hw97.fsf@amadeus.openinformatics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


"Michel Dänzer" <michdaen@iiic.ethz.ch> writes:

> > Bummer... seems like XFree86 has ProjectRoot hard-coded into the
> > binary. I'll have to recompile with ProjectRoot not redefined.
>
> Why?
>
> Note that you needn't install anything to try a new version, check out the
> -modulepath option of the XFree86 binary. Sorry I forgot to point this out
> earlier.

Aaah... yes, that would have helped. I figured there had to be an
option like that. My mistake was to go looking for an environment
variable and not for a command line option. Next time, I'll just write
an email.

OK. With the new XFree86 binary it can't load the r128 driver:

(EE) R128(0): Cannot read V_BIOS (4)

I'm attaching the whole log, as well as my config file.

Thanks,
jas.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
