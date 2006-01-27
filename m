Return-Path: <grant.likely@secretlab.ca>
Received: from outbound-mail-06.bluehost.com (outbound-mail-06.bluehost.com
	[67.138.240.206]) by ozlabs.org (Postfix) with SMTP id EA61A68A10
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 28 Jan 2006 03:37:23 +1100 (EST)
In-Reply-To: <259581790601270401g279663c9k1472c4e8b2bd5406@mail.gmail.com>
References: <259581790601270401g279663c9k1472c4e8b2bd5406@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=ISO-8859-1; delsp=yes; format=flowed
Message-Id: <A1577D91-D5B1-4637-B84A-3DEBFC8E47C8@secretlab.ca>
From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 00/10] Updated ML300 & ML403 patches
Date: Fri, 27 Jan 2006 09:37:21 -0700
To: =?ISO-8859-1?Q?Paula_Saame=F1o?= <gnathita@gmail.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On 27-Jan-06, at 5:01 AM, Paula Saame=F1o wrote:

> Hi!
>
> I have tested the patches on the git kernel 2.6 and the reference =20
> design for the ml403, and it boot sucessfully. Thanks for the support!
>
> Have any of you tried to mount the root fs via NFS? I haven't been =20
> able to. I think that, as long as there is no driver for the Xilinx =20=

> EMAC yet, I cannot do it, can I?
That's right.  I've ported the 2.4 EMAC driver to 2.6, but I don't =20
have permission from my client to release it yet.  I think MontaVista =20=

is also working on an updated driver; you could ping them

>
> Thanks one more time!
No problem.
