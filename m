Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <40C99182.8050201@intracom.gr>
Date: Fri, 11 Jun 2004 14:03:30 +0300
From: Pantelis Antoniou <panto@intracom.gr>
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
Cc: Meriin Michael-BMM063 <Meriin@motorola.com>,
	"'Ricardo DIz'" <rdiz@alumni.deec.uc.pt>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: U-Boot and kernel 2.6
References: <0F48024310E5D6118D200002B3A440DB08B07A3D@zil01exm08.mcil.comm.mot.com> <1086950206.15845.1268.camel@hades.cambridge.redhat.com>
In-Reply-To: <1086950206.15845.1268.camel@hades.cambridge.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


David Woodhouse wrote:

>On Thu, 2004-06-10 at 09:45 +0300, Meriin Michael-BMM063 wrote:
>
>>Check the bd_t definition, it MUST be the same in u-boot and Linux platform definition.
>>bd_t in Linux is defined in ppcboot.h
>>
>
>We really need to throw this crap away and start using structured tags
>like ARM does.
>
>--
>dwmw2
>
>
>
>
>
>
Or we can parse the u-boot environment which is ascii.
I already do this...

Regards

Pantelis


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
