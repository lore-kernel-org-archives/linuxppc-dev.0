Return-Path: <glikely@secretlab.ca>
Received: from mail-yw0-f199.google.com (mail-yw0-f199.google.com
	[209.85.211.199]) by ozlabs.org (Postfix) with ESMTP id EBAE5B7088
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Nov 2009 04:06:50 +1100 (EST)
Received: by ywh37 with SMTP id 37so3136708ywh.17
	for <linuxppc-dev@ozlabs.org>; Mon, 09 Nov 2009 09:06:49 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1257358349.2489.0@antares>
References: <4AF084C6.3020602@nortel.com> <1257358349.2489.0@antares>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 9 Nov 2009 10:06:29 -0700
Message-ID: <fa686aa40911090906pb586592g497de2de50001b5b@mail.gmail.com>
Subject: Re: Fwd: [PATCH] arch/powerpc: Improve _memcpy
To: =?ISO-8859-1?Q?Albrecht_Dre=DF?= <albrecht.dress@arcor.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Dirk Eibach <eibach@gdsys.de>, Linux kernel <linux-kernel@vger.kernel.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Nov 4, 2009 at 11:12 AM, Albrecht Dre=DF <albrecht.dress@arcor.de> =
wrote:
> See <http://lists.ozlabs.org/pipermail/linuxppc-dev/2009-May/072582.html>=
.
> =A0Any chance to get this one into the tree? =A0Grant?

Even though it is generic ppc code, I picked it up into my 5200 -next
tree because it's such a simple patch.  I expect Ben will pull it into
his any day now.

Cheers,
g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
