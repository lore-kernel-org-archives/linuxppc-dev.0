Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <40C9B249.4070905@intracom.gr>
Date: Fri, 11 Jun 2004 16:23:21 +0300
From: Pantelis Antoniou <panto@intracom.gr>
MIME-Version: 1.0
To: Wolfgang Denk <wd@denx.de>
Cc: David Woodhouse <dwmw2@infradead.org>,
	Meriin Michael-BMM063 <Meriin@motorola.com>,
	"'Ricardo DIz'" <rdiz@alumni.deec.uc.pt>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: U-Boot and kernel 2.6
References: <20040611130309.6E605C109F@atlas.denx.de>
In-Reply-To: <20040611130309.6E605C109F@atlas.denx.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Wolfgang Denk wrote:

>In message <40C99182.8050201@intracom.gr> you wrote:
>
>[David Woodhouse:]
>
>
>>>We really need to throw this crap away and start using structured tags
>>>like ARM does.
>>>
>
>Right (or bi_rec's or whatever this might end up being called).
>
>
>>Or we can parse the u-boot environment which is ascii.
>>I already do this...
>>
>
>No, this is IMHO not a good idea. Some of the information that  needs
>to  be  passed to the kernel is not contained in the envrionment, and
>does not belong there.
>
I'm just talking about augmenting the information provided by bd_t.

And it's not just things that the kernel needs, it can be used to
pass information to the user-space applications.

Reading the environment from flash is not correct because the
variables might be modified by the boot sequence but not commited.

When I get some breathing time, I'll sent you the patch.

>
>Best regards,
>
>Wolfgang Denk
>
>
Regards

Pantelis


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
