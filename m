Return-Path: <kumar.gala@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id DDB5B67A6D
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 30 Mar 2005 14:20:57 +1000 (EST)
In-Reply-To: <84ab51297f043a761321ee6eddc43d4a@embeddededge.com>
References: <84ab51297f043a761321ee6eddc43d4a@embeddededge.com>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <1c52c0b6db38845c0bd6636e056d4c64@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Tue, 29 Mar 2005 22:20:36 -0600
To: "Dan Malek" <dan@embeddededge.com>
Cc: Andrew Morton <akpm@osdl.org>, shall@mvista.com,
	linux-kernel@vger.kernel.org, Kumar Gala <galak@freescale.com>,
	linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] ppc32: CPM2 PIC cleanup irq_to_siubit array
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Done, updated patch w/comment sent to Andrew.

- kumar

On Mar 29, 2005, at 7:10 PM, Dan Malek wrote:

>
>
> On Mar 29, 2005, at 5:30 PM, Kumar Gala wrote:
>
> > Cleaned up irq_to_siubit array so we no longer need to do 1 <<
> > (31-bit),
>  > just 1 << bit.
>
> Will you please put a comment in here that indicates this array now
>  has this computation done?=A0 When I wrote it, these bit numbers
>  matched the registers and the documentation, so I didn't take
> the time to explain. :-)
>
> Thanks.
>
>
>
> =A0=A0=A0=A0=A0=A0=A0 -- Dan
