Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.241])
	by ozlabs.org (Postfix) with ESMTP id 8AAA8DDE07
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Mar 2008 08:50:48 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so797788anc.78
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Mar 2008 14:50:45 -0700 (PDT)
Message-ID: <fa686aa40803131450p5ce9f0d9j1239e6683b2ff3a8@mail.gmail.com>
Date: Thu, 13 Mar 2008 15:50:44 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "=?ISO-8859-1?Q?Ren=E9_B=FCrgel?=" <r.buergel@unicontrol.de>
Subject: Re: [PATCH] Linux >=2.6.24 support for FEC on MPC5200 (not B!)
In-Reply-To: <47D827A5.8040701@unicontrol.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <47D827A5.8040701@unicontrol.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Mar 12, 2008 at 12:57 PM, Ren=E9 B=FCrgel <r.buergel@unicontrol.de>=
 wrote:
> Here is a patch for the lite5200 to get the FEC working again for kernel
>   >=3D2.6.24. It was created against Linux 2.6.24.
>
>  The FEC driver is also compatible with the MPC5200, not only with the
>  MPC5200B, so an according entry was added to the drivers matching list.
>  Furthermore the settings for the PHY were entered in the dts file for
>  the Lite5200. Note, that this is not exactly the same as in the
>  Lite5200B, because the PHY is located at f0003000:01 for the 5200, and
>  at :00 for the 5200B. I could test the patch on a Lite5200 and a
>  Lite5200B, both booted a kernel via tftp and mounted the root via nfs
>  successfully.
>  I hope, you can include the patch into the official tree.

Looks good.  I'll pick this one up.

g.


--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
