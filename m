Return-Path: <bdonadt@arabellasw.com>
Received: from gold.webfusion.co.uk (gold.webfusion.co.uk [212.67.202.159])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EED5967A70
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 29 Mar 2005 01:59:40 +1000 (EST)
From: "Bruce Donadt" <bdonadt@arabellasw.com>
To: "Autran, Guillaume" <gautran@mrv.com>,
	"'Marcelo Tosatti '" <marcelo.tosatti@cyclades.com>
Date: Mon, 28 Mar 2005 10:57:33 -0500
Message-ID: <NEBBIHDFOLIPIPJAKJAMMELCGEAA.bdonadt@arabellasw.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <19EE6EC66973A5408FBE4CB7772F6F0A210598@ltnmail.xyplex.com>
Cc: 'linuxppc-embedded ' <linuxppc-embedded@ozlabs.org>
Subject: RE: MPC885 CryptoApi support.
Reply-To: bdonadt@arabellasw.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Guillaume and Marcelo:

My post on this list about Arabella's support for the PQ1 and PQ2 on board
security device as well as the enhancements we have made to CryptoApi and
IPsec was meant to be just a quick note to those interested that there is a
solution available although it is a commercial solution. I am reluctant to
continue a discussion about a commercial offering in this forum. You may
feel free to contact me directly with further questions.

To answer the original question. The code is provided under a GPL license to
companies that purchase a subscription to the Arabella Linux distribution.
We have invested many man months in developing a commercial grade security
solution for the PowerQUICCs and all of it has been written from the ground
up. You are correct when you say that none of this is included in our "free"
evaluation kit.

Best Regards,

Bruce

-----Original Message-----
From: Autran, Guillaume [mailto:gautran@mrv.com]
Sent: Monday, March 28, 2005 10:34 AM
To: 'Marcelo Tosatti '; 'Bruce Donadt '
Cc: 'linuxppc-embedded '
Subject: RE: MPC885 CryptoApi support.


Not sure. It seems that not all of the Linux kernel source they modified is
freely available. The "free" evaluation kit only contains an old version of
2.4.x kernel and definitely, no support for the MPC885 SEC-Lite.
So, unless they rewrote the all thing, I don't understand how it could be...



-----Original Message-----
From: Marcelo Tosatti
To: Bruce Donadt
Cc: Autran, Guillaume; linuxppc-embedded
Sent: 03/24/2005 6:39 AM
Subject: Re: MPC885 CryptoApi support.

On Mon, Mar 21, 2005 at 03:54:39PM -0500, Bruce Donadt wrote:
> Guillaume:
>
> Arabella Software provides asynchronous 2.6 kernel CryptoApi support
for the
> MPC885 as well as the PowerQUICC II devices as part of our
commercially
> supported Linux distribution. If you would be interested in a
commercial
> open source offering, please feel free to contact me and I can provide
> further detail.

These drivers are not GPL, then?
