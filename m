Return-Path: <jdl@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id BCC7EDDFBE
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 12 Jun 2008 00:03:54 +1000 (EST)
Message-ID: <484FDB3D.4040101@freescale.com>
Date: Wed, 11 Jun 2008 09:03:41 -0500
From: Jon Loeliger <jdl@freescale.com>
MIME-Version: 1.0
To: vb <vb@vsbe.com>
Subject: Re: PPC to PowerPC Migration
References: <c443b0db0806101048t1df8c11ag456fbc352709966b@mail.gmail.com>	<161B3BAD77161449A144FF054231C3D6022A3E4A@uss-am-xch-01.am.trimblecorp.net>
	<f608b67d0806110655v19dac162wc3adfc8939b5c40a@mail.gmail.com>
In-Reply-To: <f608b67d0806110655v19dac162wc3adfc8939b5c40a@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Mike Timmons <mike_timmons@trimble.com>,
	Andy Schmidt <andrewgschmidt@gmail.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

vb wrote:
> I recently ported two platforms (8245 and 8541) from ppc tree in
> earlier 2.6 versions into powerpc tree in 2.6.25. It is amazing how
> little the device tree contents are described, a lot of things
> required reverse engineering of the kernel code to understand the
> meaning of some numbers in the  tree.
> 
> I am also willing to contribute into a document describing this
> transition, please keep me in the loop,
> 
> regards,
> Vadim


Well, perhaps as a starting point you could tell us
which things required reverse engineering or what you
were not able to find in a document?

Thanks,
jdl
