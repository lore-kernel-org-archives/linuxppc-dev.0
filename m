Return-Path: <esbenhaabendal@gmail.com>
Received: from qw-out-2122.google.com (qw-out-2122.google.com [74.125.92.25])
	by ozlabs.org (Postfix) with ESMTP id B59E6DE060
	for <linuxppc-dev@ozlabs.org>; Tue, 26 May 2009 21:30:23 +1000 (EST)
Received: by qw-out-2122.google.com with SMTP id 3so1924744qwe.15
	for <linuxppc-dev@ozlabs.org>; Tue, 26 May 2009 04:30:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4A124202.4010201@doredevelopment.dk>
References: <4A124202.4010201@doredevelopment.dk>
Date: Tue, 26 May 2009 13:30:21 +0200
Message-ID: <d2b9ea600905260430i72290901p9266de4cade049c1@mail.gmail.com>
Subject: Re: [PATCH v2] i2c-mpc: generate START condition after STOP caused by
	read i2c_msg
From: Esben Haabendal <esbenhaabendal@gmail.com>
To: Esben Haabendal <eha@doredevelopment.dk>
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

On Tue, May 19, 2009 at 7:22 AM, Esben Haabendal <eha@doredevelopment.dk> w=
rote:
> This fixes MAL (arbitration lost) bug caused by illegal use of
> RSTA (repeated START) after STOP condition generated after last byte
> of reads. With this patch, it is possible to do an i2c_transfer() with
> additional i2c_msg's following the I2C_M_RD messages.
>
> It still needs to be resolved if it is possible to fix this issue
> by removing the STOP condition after reads in a robust way.
>
> Signed-off-by: Esben Haabendal <eha@doredevelopment.dk>
> ---
> =A0drivers/i2c/busses/i2c-mpc.c | =A0 =A09 +++++++--
> =A01 files changed, 7 insertions(+), 2 deletions(-)

Any blockers to get this accepted?

/Esben
