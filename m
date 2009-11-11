Return-Path: <glikely@secretlab.ca>
Received: from mail-yw0-f199.google.com (mail-yw0-f199.google.com
	[209.85.211.199]) by ozlabs.org (Postfix) with ESMTP id 2D809B70CF
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Nov 2009 07:18:57 +1100 (EST)
Received: by ywh37 with SMTP id 37so1444647ywh.17
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Nov 2009 12:18:56 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <16246194.1257928342802.JavaMail.ngmail@webmail19.ha2.local>
References: <fa686aa40911101159y7bef3f9bte74e9aeb5c6e864b@mail.gmail.com>
	<1257884778.14374.5@antares>
	<fa686aa40911101307p12bba31s491ef1d8812ca033@mail.gmail.com>
	<16246194.1257928342802.JavaMail.ngmail@webmail19.ha2.local>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 11 Nov 2009 13:18:36 -0700
Message-ID: <fa686aa40911111218g62bf8f50k99c786ec6f5421b4@mail.gmail.com>
Subject: Re: Re: [PATCH 3/3] mpc52xx/wdt: WDT uses GPT api
To: =?ISO-8859-1?Q?Albrecht_Dre=DF?= <albrecht.dress@arcor.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@lists.ozlabs.org, wim@iguana.be
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Nov 11, 2009 at 1:32 AM, Albrecht Dre=DF <albrecht.dress@arcor.de> =
wrote:
> Hi Grant:
>
> O.k., thanks for your comments. =A0If Wim doesn't have any objections to =
it, I will provide a merged patch. =A0One consequence I forgot to mention i=
s that we loose the ability to build the wdt support as module, but I don't=
 think it's a real problem.

I'm not too worried about this.  It is also potentially possible to
rework the entire GPT driver as a module.  But there are non-trivial
architecture fiddly bits needed to make it safe to load IRQ
controllers in a module.

> I think we still should keep the kernel config option enable/disable the =
wdt support, which would mask out the wdt code if disabled. =A0Is that ok f=
or you?

Yup.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
