Return-Path: <glikely@secretlab.ca>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.228])
	by ozlabs.org (Postfix) with ESMTP id 916C0DDE26
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 12 Jul 2007 06:11:18 +1000 (EST)
Received: by nz-out-0506.google.com with SMTP id l1so1402400nzf
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 11 Jul 2007 13:11:17 -0700 (PDT)
Message-ID: <fa686aa40707111311i42ed56bdiff24d2680b4a8297@mail.gmail.com>
Date: Wed, 11 Jul 2007 14:11:16 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Kevin Holland" <KHollan@daktronics.com>,
	"Linux PPC Linux PPC" <linuxppc-embedded@ozlabs.org>
Subject: Re: TEMAC MAC address
In-Reply-To: <3D99384DA1D6124CBE9EE993BAA0E5B70195FDFD@exbe-dak-01.daktronics.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <3D99384DA1D6124CBE9EE993BAA0E5B70195FDFD@exbe-dak-01.daktronics.lan>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 7/11/07, Kevin Holland <KHollan@daktronics.com> wrote:
> Grant,
>  How do I set the MAC address?

Badly, with an ugly hack.  :-)

> When my ML410 board boots its Hardware
> address is set to 0.  I looked through the message boards and can't seem
> to find what Im looking for.  Thanks for your help.

I set the mac addr with some Virtex specific code in
arch/ppc/boot/simple/embed_config.c.

BTW, Please at least CC: the mailing list when asking questions.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
