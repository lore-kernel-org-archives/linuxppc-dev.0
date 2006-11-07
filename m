Return-Path: <tnt@246tNt.com>
Message-ID: <4550F221.9060604@246tNt.com>
Date: Tue, 07 Nov 2006 21:52:49 +0100
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH/RFC] powerpc: Add MPC5200 Interrupt Controller support.
References: <200611071040.kA7Aeea6006482@post.webmailer.de>	
	<455063C6.6070205@246tNt.com>
	<528646bc0611070830u2d490d79v5843de918c54b05f@mail.gmail.com>
In-Reply-To: <528646bc0611070830u2d490d79v5843de918c54b05f@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, sven@genesi-usa.com, linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Grant Likely wrote:
> On 11/7/06, Sylvain Munaut <tnt@246tnt.com> wrote:
>> Nicolas DET wrote:
>>
>> > This patch add MPC52xx Interrupt controller for ARCH=powerpc.
>> >
>> > It includes the main code in arch/powerpc/sysdev/ ad well as an
>> header file in
>> > include/asm-powerpc.
>> >
>> > The header file has now distinct section for the struct and the IRQ
>> mapping/enconding define
>> >
>> > Signed-off-by: Nicolas DET <nd@bplan-gmbh.de>
>> Acked-by: Sylvain Munaut <tnt@246tNt.com>
> Acked-by: Grant Likely <grant.likely@secretlab.ca>
>
OOps ... sorry NAK ...

All your strings got screwed up ... all your \n got replaced by just n ...

And while your at it there is two extraneous whitespace, might be a good
time to get rid
of them. One in the comment header and one after a "size64".


    Sylvain
