Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3F1079FA.3050901@earthlink.net>
Date: Sat, 12 Jul 2003 14:13:30 -0700
From: Dean Matsen <deanm@earthlink.net>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Cc: Tom Rini <trini@kernel.crashing.org>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Ethernet PHY chip discovery not working on 855T with 971/972
 chips
References: <3F0C8112.5060001@earthlink.net>	<20030709212145.49E24C6D82@atlas.denx.de>	<20030711151834.GU17433@ip68-0-152-218.tc.ph.cox.net>	<3F0F468F.1050909@earthlink.net> <16143.24034.31805.589402@cargo.ozlabs.ibm.com>
In-Reply-To: <16143.24034.31805.589402@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Paul Mackerras wrote:

>Dean Matsen writes:
>
>
>
>>Somewhere in this discussion thread I saw that the 2.4 kernel is closed for
>>patches (I just joined this list, so I didn't know that).
>>
>>
>
>Well, that's not strictly true, we will continue to fix things that
>are broken, but I would prefer than any new development (e.g. support
>for new boards or devices) happened in 2.5.  It's a bit disappointing
>that 8xx still doesn't compile in 2.5.  I don't have any 8xx hardware
>to test on so I have been relying on others to update it.
>
>
Ok, in that case I do have ONE thing that I know should be fixed, but
I haven't seen any response on it, so I am wondering if anyone noticed
it at all. See

http://lists.linuxppc.org/linuxppc-dev/200307/msg00085.html

This affects existing support. It's so simple that:
a) It's kind of annoying to 8xx people
b) probably everyone will figure it out
c) there is really no risk in fixing it.

>
>
>>Would it help if I came up with a 2.5 patch for fec.c? I made a few minor
>>changes that will make it behave friendlier for all [to whom it is not
>>already being totally friendly], and I see the 2.5 kernel could use some
>>of the same changes.
>>
>>
>
>Excellent idea. :)
>
>Paul.
>
>
>
>
>
I would love to see the kernel perform well for mpc8xx users right out
of the
box, so I am highly motivated to contibute. I'll focus on the 2.5 kernel
(I'm surprised to hear it doesn't compile).


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
