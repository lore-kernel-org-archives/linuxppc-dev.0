Return-Path: <glikely@secretlab.ca>
Received: from mail-yw0-f187.google.com (mail-yw0-f187.google.com
	[209.85.211.187]) by ozlabs.org (Postfix) with ESMTP id 39ED9B6EF0
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 21 Nov 2009 19:46:13 +1100 (EST)
Received: by ywh17 with SMTP id 17so3643892ywh.2
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 21 Nov 2009 00:46:10 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20091118232920.GA24307@oksana.dev.rtsoft.ru>
References: <200911161742.46663.to-fleischer@t-online.de>
	<20091117202211.GB27574@oksana.dev.rtsoft.ru>
	<20091117232823.GA19058@oksana.dev.rtsoft.ru>
	<200911181720.06390.to-fleischer@t-online.de>
	<20091118232920.GA24307@oksana.dev.rtsoft.ru>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Sat, 21 Nov 2009 01:45:50 -0700
Message-ID: <fa686aa40911210045v4be84e8dg8ef490472e06017b@mail.gmail.com>
Subject: Re: spi_mpc8xxx.c: chip select polarity problem
To: avorontsov@ru.mvista.com
Content-Type: text/plain; charset=ISO-8859-1
Cc: Torsten Fleischer <to-fleischer@t-online.de>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Nov 18, 2009 at 4:29 PM, Anton Vorontsov
<avorontsov@ru.mvista.com> wrote:
> On Wed, Nov 18, 2009 at 05:20:06PM +0100, Torsten Fleischer wrote:
> [...]
>> > Oh. On the other hand, we can postpone the gpio_direction_output()
>> > call, and still require that the platform code (or firmware)
>> > should be responsible for setting a sane default values on the
>> > chip selects.
>> >
>>
>> How about that?
>
> Looks great, thanks!
>
> Few minor issues below.

Hey Torsten,  do you have an updated version of this change to address
the comments?  I'm collecting the last few things for some linux-next
exposure now.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
