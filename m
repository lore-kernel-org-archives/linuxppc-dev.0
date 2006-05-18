Return-Path: <jimix@watson.ibm.com>
Received: from igw2.watson.ibm.com (igw2.watson.ibm.com [129.34.20.6])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2B94A67A63
	for <linuxppc-dev@ozlabs.org>; Fri, 19 May 2006 02:52:33 +1000 (EST)
In-Reply-To: <1147967806.8469.10.camel@localhost.localdomain>
References: <E1FgORv-0001dS-Hu@heater.watson.ibm.com>
	<1147908963.7360.1.camel@localhost.localdomain>
	<34FAC3E5-F717-4640-B094-312C8773852E@watson.ibm.com>
	<1147967806.8469.10.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg=pgp-sha1; boundary="Apple-Mail-8-12719978"
Message-Id: <68EF7C38-A8DB-445A-BC7F-439102E19BB9@watson.ibm.com>
From: Jimi Xenidis <jimix@watson.ibm.com>
Subject: Re: [PATCH][resend] udbg_printf() formatting attribute
Date: Thu, 18 May 2006 12:52:07 -0400
To: michael@ellerman.id.au
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-8-12719978
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed


On May 18, 2006, at 11:56 AM, Michael Ellerman wrote:
>
> I'm actually hoping to get rid of udbg_printf(), but if I can't we
> should stick this in I guess. The real problem IMHO is that debug
> printks rot because they're rarely compiled, not sure what to do about
> that.

Yeah, debug code always has that problem.  But I must say, whenever I  
work with the x86 guys and I see how long they are _blind_ when they  
boot it blows my mind.  Lets hope we don't go there.
-JX

--Apple-Mail-8-12719978
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (Darwin)

iD8DBQFEbKZHd/h5j14PFR4RAhfoAJ9FCG47NBGBEMHtKBLIDRYqrDKBHACgru1S
7HlGQriAj7pXbv6K6AzgiUg=
=Uehz
-----END PGP SIGNATURE-----

--Apple-Mail-8-12719978--
