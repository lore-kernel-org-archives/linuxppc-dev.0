Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3CCE1653.7050709@embeddededge.com>
Date: Mon, 29 Apr 2002 23:58:11 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
Cc: leeyang <leeyang77@hotmail.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: [trini@kernel.crashing.org: [PATCH] Allow openpic_init to set
 all combos of polarity and sense]
References: <20020430003434.GA21482@opus.bloom.county> <OE120wZDyDG742l3ew100002f33@hotmail.com> <20020430033341.GB21482@opus.bloom.county>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Tom Rini wrote:

> Note, Sandpoint is probably currently broken in linuxppc_2_4_devel since
> I believe it relied on overloading NumInitSenses .....

I thought Paulus finally took this hack and implemented it in a way
that made him happy. :-)  Was I mistaken?  Several of us checked this
in over and over, it really shouldn't be removed unless there is
something better.

Thanks.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
