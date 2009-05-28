Return-Path: <esbenhaabendal@gmail.com>
Received: from mail-qy0-f123.google.com (mail-qy0-f123.google.com
	[209.85.221.123]) by ozlabs.org (Postfix) with ESMTP id 6D0E2DDF7C
	for <linuxppc-dev@ozlabs.org>; Fri, 29 May 2009 06:15:24 +1000 (EST)
Received: by qyk29 with SMTP id 29so1897887qyk.17
	for <linuxppc-dev@ozlabs.org>; Thu, 28 May 2009 13:15:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <fa686aa40905281231o26c74a13v250bcedbd066e77b@mail.gmail.com>
References: <4A124202.4010201@doredevelopment.dk>
	<d2b9ea600905260430i72290901p9266de4cade049c1@mail.gmail.com>
	<fa686aa40905281231o26c74a13v250bcedbd066e77b@mail.gmail.com>
Date: Thu, 28 May 2009 22:15:22 +0200
Message-ID: <d2b9ea600905281315x435cdb05ia7b016b3d60c4a65@mail.gmail.com>
Subject: Re: [PATCH v2] i2c-mpc: generate START condition after STOP caused by
	read i2c_msg
From: Esben Haabendal <esbenhaabendal@gmail.com>
To: Kumar Gala <galak@gate.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, linux-i2c@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, May 28, 2009 at 9:31 PM, Grant Likely <grant.likely@secretlab.ca> w=
rote:
> On Tue, May 26, 2009 at 5:30 AM, Esben Haabendal wrote:
>> On Tue, May 19, 2009 at 7:22 AM, Esben Haabendal wrote:
>>> This fixes MAL (arbitration lost) bug caused by illegal use of
>>> RSTA (repeated START) after STOP condition generated after last byte
>>> of reads. With this patch, it is possible to do an i2c_transfer() with
>>> additional i2c_msg's following the I2C_M_RD messages.
>>>
>>> It still needs to be resolved if it is possible to fix this issue
>>> by removing the STOP condition after reads in a robust way.
>>>
>>> Signed-off-by: Esben Haabendal <eha@doredevelopment.dk>
>>> ---
>>> =A0drivers/i2c/busses/i2c-mpc.c | =A0 =A09 +++++++--
>>> =A01 files changed, 7 insertions(+), 2 deletions(-)
>>
>> Any blockers to get this accepted?
>
> It helps if you cc: developers/maintainers of the device. =A0ie. Kumar
> for mpc8xxx, me for 52xx.
>
> This is the first time I noticed your posting. =A0It will take me a few
> days before I get a chance to review it.

Kumar, will you take a look at this patch?

/Esben
