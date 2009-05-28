Return-Path: <glikely@secretlab.ca>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.31])
	by ozlabs.org (Postfix) with ESMTP id 90E83DDE21
	for <linuxppc-dev@ozlabs.org>; Fri, 29 May 2009 05:31:42 +1000 (EST)
Received: by yw-out-2324.google.com with SMTP id 2so2557354ywt.39
	for <linuxppc-dev@ozlabs.org>; Thu, 28 May 2009 12:31:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <d2b9ea600905260430i72290901p9266de4cade049c1@mail.gmail.com>
References: <4A124202.4010201@doredevelopment.dk>
	<d2b9ea600905260430i72290901p9266de4cade049c1@mail.gmail.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 28 May 2009 13:31:20 -0600
Message-ID: <fa686aa40905281231o26c74a13v250bcedbd066e77b@mail.gmail.com>
Subject: Re: [PATCH v2] i2c-mpc: generate START condition after STOP caused by
	read i2c_msg
To: Esben Haabendal <esbenhaabendal@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, linux-i2c@vger.kernel.org,
	Esben Haabendal <eha@doredevelopment.dk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, May 26, 2009 at 5:30 AM, Esben Haabendal
<esbenhaabendal@gmail.com> wrote:
> On Tue, May 19, 2009 at 7:22 AM, Esben Haabendal <eha@doredevelopment.dk>=
 wrote:
>> This fixes MAL (arbitration lost) bug caused by illegal use of
>> RSTA (repeated START) after STOP condition generated after last byte
>> of reads. With this patch, it is possible to do an i2c_transfer() with
>> additional i2c_msg's following the I2C_M_RD messages.
>>
>> It still needs to be resolved if it is possible to fix this issue
>> by removing the STOP condition after reads in a robust way.
>>
>> Signed-off-by: Esben Haabendal <eha@doredevelopment.dk>
>> ---
>> =A0drivers/i2c/busses/i2c-mpc.c | =A0 =A09 +++++++--
>> =A01 files changed, 7 insertions(+), 2 deletions(-)
>
> Any blockers to get this accepted?

It helps if you cc: developers/maintainers of the device.  ie. Kumar
for mpc8xxx, me for 52xx.

This is the first time I noticed your posting.  It will take me a few
days before I get a chance to review it.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
