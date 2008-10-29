Return-Path: <neko@genesi-usa.com>
Received: from qw-out-2122.google.com (qw-out-2122.google.com [74.125.92.25])
	by ozlabs.org (Postfix) with ESMTP id 87884DDDE0
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Oct 2008 02:34:22 +1100 (EST)
Received: by qw-out-2122.google.com with SMTP id 9so47778qwb.15
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Oct 2008 08:34:21 -0700 (PDT)
Message-ID: <4908827C.1080002@genesi-usa.com>
Date: Wed, 29 Oct 2008 10:34:20 -0500
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH]: [MPC5200] Add ATA DMA support
References: <DD39B5C3F4963040ADC9768BE7E430CB03203A7B@is-hdq-exchange.marel.net>	<792f5f410808120730j7b4be4f2n7a40de880178ccca@mail.gmail.com>	<DD39B5C3F4963040ADC9768BE7E430CB03203ADC@is-hdq-exchange.marel.net>	<792f5f410808120830v311e0446kc8fddfb97d0b9ea6@mail.gmail.com>	<DD39B5C3F4963040ADC9768BE7E430CB03203B75@is-hdq-exchange.marel.net>	<792f5f410808122257t3711eb2lfc1e02bacade16a3@mail.gmail.com>	<fa686aa40808122302g197a8e90idc721796aa35ff05@mail.gmail.com>	<792f5f410808122306u478b3ere8167016ef892323@mail.gmail.com>	<20080813061135.GH17587@secretlab.ca>	<792f5f410808130207t6ef3c3ddxeff0ad0debb39242@mail.gmail.com>
	<fa686aa40809142254m68eaf3e8n614564a74667fcdf@mail.gmail.com>
In-Reply-To: <fa686aa40809142254m68eaf3e8n614564a74667fcdf@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: Matt Sealey <neko@genesi-usa.com>
Cc: Tim Yamin <plasm@roo.me.uk>, linuxppc-dev@ozlabs.org, "Bienert,
	Shawn" <Shawn.Bienert@gdcanada.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



Grant Likely wrote:
> On Wed, Aug 13, 2008 at 3:07 AM, Tim Yamin <plasm@roo.me.uk> wrote:
>> On Wed, Aug 13, 2008 at 7:11 AM, Grant Likely <grant.likely@secretlab.ca> wrote:
>>> Sounds good to me.  You will get more testers that way.  I can pick it
>>> up for -next if everything else looks good.
>> Here are the new patches; tested against 2.6.27-rc3.
> 
> Hi Tim,
> 
> I finally got a chance to try out your patches on my lite5200 board.
> Unfortunately, I wasn't able to get it to work easily.  I'm very early
> in the debugging this issue, but I thought I'd send you my results in
> case you've seen it before.  I've tried this with both an STEC 1GB CF
> and a Transcend Ultra industrial 1GB CF card.

[snip]

Grant, Tim,

Any chance of this being picked up even though it "doesn't work"?

I'm going to be rolling a couple kernels this weekend (2.6.27.4
for Efika, ADS512101, 8610HPCN and 8641DHPCD) and I'll patch this
in and see what happens and give some more test data (since my
Efika is nice and trashed it won't matter if I trash it some
more).

We at Genesi still hold by the fact that ATA DMA is irrevocably
broken but hold some bittersweet hope that Freescale might fix
it after the fact in some useless future revision, the biggest
problem is that if nobody writes a driver for it, nobody experiences
the problem!

Once the patch is in maybe someone will be willing to use the
BestComm-assisted PIO idea as implemented in the bplan 2.6.19
kernel and compare results?

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations
