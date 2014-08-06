Return-Path: <broonie@sirena.org.uk>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [IPv6:2400:8900::f03c:91ff:fedb:4f4])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B6C741A008C
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Aug 2014 06:12:55 +1000 (EST)
Date: Wed, 6 Aug 2014 21:12:36 +0100
From: Mark Brown <broonie@kernel.org>
To: Nicolin Chen <Guangyu.Chen@freescale.com>
Message-ID: <20140806201236.GO17528@sirena.org.uk>
References: <1407223925-29678-1-git-send-email-nicoleotsuka@gmail.com>
 <53E0B926.9010103@gmail.com> <20140805110735.GA16503@MrMyself>
 <53E0BC95.7040208@gmail.com> <20140806024236.GA17879@MrMyself>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="ZWXtK32sF+lMTTLi"
In-Reply-To: <20140806024236.GA17879@MrMyself>
Subject: Re: [PATCH] ASoC: fsl_sai: Add asynchronous mode support
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, b42378@freescale.com, pawel.moll@arm.com,
 ijc+devicetree@hellion.org.uk, Varka Bhadram <varkabhadram@gmail.com>,
 b02247@freescale.com, linux-kernel@vger.kernel.org, robh+dt@kernel.org,
 timur@tabi.org, Nicolin Chen <nicoleotsuka@gmail.com>, Li.Xiubo@freescale.com,
 galak@codeaurora.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--ZWXtK32sF+lMTTLi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 06, 2014 at 10:42:37AM +0800, Nicolin Chen wrote:
> On Tue, Aug 05, 2014 at 04:44:29PM +0530, Varka Bhadram wrote:

> > Reading comfortably is important for us...  :-)
> > see this:http://lxr.free-electrons.com/source/Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt#L46

> I know how to write a binding doc with indentations to make it clear.

> What I'm talking about is that the doc was created without indentations,
> so I don't feel comfortable to add indentations starting from this patch
> while leaving the old lines in totally a different style because It's not
> helpful to make people read comfortably at all but only forcing people to
> think why these two lines are so special to take some steps back here.

> So personally I agree with your idea to make doc more readable. But what
> I prefer to do is not having a conversation on the style within this patch
> but to create an extra style-refinement patch later after this one.

This is the right approach.

--ZWXtK32sF+lMTTLi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT4owxAAoJELSic+t+oim9KcIQAICotBQolgWw5UxLxsPdDXn6
0FWS1aFBrD5ihL5ddLrznh/gHaCclN1FQWggU/LjmDjfXr4tddRSUP0NYgTo8HBJ
fCKLmrXe/sfbMxl7W8sz7DuXLvy8qO7Q5KYjX4B8HKAu23m/trwcux25vkOpi5dP
T7sHjU0pyw6zm+62Knv/IvUiPMePRjS4OkAPo5F+vYWG5rtHsGnjPdcIV+SnBxPj
n17q7guf54qL4Or8bbT0G5Tmhiuz1m6ji/dObt8e7OSvd/83O4oreMg5uJ0umLWT
Ylrg7InGH2m8rCF6EQs9GoEQVttfI00uE5TQPxweO+WssyhrAigTunslnuUBVzhE
EJzNzABbawTE8oxlynWyFMJJWSoNSBHwUgXSqdPqq5FdB5ueZu6FIELQU/8AD4He
mAWAlehGQj8Sm1ppHKjw8eRWh2il8CDjk8vrFzxTAvkPrht+f2LwkbGMPGEA7TIU
t85u2rxwGQ6UdZNriA+JawhCnKDVBWXQvTkPosrsjW+Z/FIYbYy7fugfyF7P6H2x
w1kqX3LqPywO+A4KaHMQyMYJ/pgDsHuxj6irMGzSC5jVe4CPOqGGUp4y+i8QNGYc
/JwWxZdWITPD12gJRF+r1ZceNcu/BYEcviUHx7EPzz5iPm6iYtFchA1On4Ih88yL
gudDN8hYeYPjVgDCWaQG
=FNp5
-----END PGP SIGNATURE-----

--ZWXtK32sF+lMTTLi--
