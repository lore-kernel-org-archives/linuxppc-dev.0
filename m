Return-Path: <glikely@gmail.com>
Received: from nproxy.gmail.com (nproxy.gmail.com [64.233.182.189])
	by ozlabs.org (Postfix) with ESMTP id EB8FF67C74
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 13 Apr 2006 04:44:56 +1000 (EST)
Received: by nproxy.gmail.com with SMTP id a25so1174739nfc
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 12 Apr 2006 11:44:54 -0700 (PDT)
Message-ID: <528646bc0604121144t16a900d3r7792c7e0b4830571@mail.gmail.com>
Date: Wed, 12 Apr 2006 12:44:54 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Martin, Tim" <tim.martin@viasat.com>
Subject: Re: question about Linux 2.6 with Xilinx ML-403
In-Reply-To: <821B2170E9E7F04FA38DF7EC21DE4871044F9E54@VCAEXCH01.hq.corp.viasat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <821B2170E9E7F04FA38DF7EC21DE4871044F9E54@VCAEXCH01.hq.corp.viasat.com>
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

On 4/12/06, Martin, Tim <tim.martin@viasat.com> wrote:
> Grant,
>
> I know I could probably figure this out by looking at the GIT tree
> directly (which I'm planning to do) but could you summarize how much
> (which devices) of the ML-403 is supported by your patches?
>
> Serial? (which Xilinx core)
Yes, full uart

>
> Ethernet? (Hard-Core PLB TEMAC?, Soft-Core PLB EMAC? Localink TEMAC? Is
> 10/100/1000 supported, or is there only 1 rate e.g. 1000 supported?)

No.  I've ported the 2.4 driver, but I haven't got permission to
release it yet.  (I'm a contractor; I don't own any of the work I do)

>
> Anything else (GPIO buttons/switches?)
I've got drivers for the PS/2 & VGA, but I'm still trying to get them relea=
sed.

Cheers,
g.
