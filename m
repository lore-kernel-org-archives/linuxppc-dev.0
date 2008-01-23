Return-Path: <jacmet@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.190])
	by ozlabs.org (Postfix) with ESMTP id 57EE0DDEC9
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jan 2008 08:20:38 +1100 (EST)
Received: by nf-out-0910.google.com with SMTP id g16so49433nfd.9
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jan 2008 13:20:36 -0800 (PST)
To: David Brownell <david-b@pacbell.net>
Subject: Re: [patch v4 0/4] Cypress c67x00 (EZ-Host/EZ-OTG) support
References: <20080121103434.397382000@sunsite.dk>
	<87sl0qzxos.fsf@macbook.be.48ers.dk>
	<fa686aa40801230912m2314209fp2545898949ed3b24@mail.gmail.com>
	<200801230953.05921.david-b@pacbell.net>
From: Peter Korsgaard <jacmet@sunsite.dk>
Date: Wed, 23 Jan 2008 22:20:32 +0100
In-Reply-To: <200801230953.05921.david-b@pacbell.net> (David Brownell's
	message of "Wed\, 23 Jan 2008 09\:53\:05 -0800")
Message-ID: <873asofdcv.fsf@macbook.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: Peter Korsgaard <jacmet@gmail.com>
Cc: linuxppc-dev@ozlabs.org, linux-usb@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>>>> "David" =3D=3D David Brownell <david-b@pacbell.net> writes:

 David> On Wednesday 23 January 2008, Grant Likely wrote:
 >> The question is about the device structure which used to be provided
 >> by the platform device instances and now there just uses the c67x00's
 >> device struct. =C2=A0I was under the impression that each USB HCD needs=
 to
 >> have it's own struct device. =C2=A0I take it that's not true?

 David> Each root hub necessarily is a unique device, representing a set
 David> of downstream links.  Unless Peter didn't test something relevant,
 David> it would seem we have observational proof that two root hubs can
 David> share the same device node for an upstream link.

I haven't actually tested a setup with HCDs on both SIEs as I don't
have a board with host connectors on both, but I've done the change
based on your feedback:

http://article.gmane.org/gmane.linux.usb.devel/53496

 David> I can't think of a reason to demand multiple upstream links, though
 David> sharing them between root hubs like that isn't a common structure.=
=20=20

 David> - Dave


--=20
Bye, Peter Korsgaard
