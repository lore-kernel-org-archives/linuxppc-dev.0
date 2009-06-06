Return-Path: <glikely@secretlab.ca>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 4B5E4B70A9
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun,  7 Jun 2009 03:27:59 +1000 (EST)
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.29])
	by ozlabs.org (Postfix) with ESMTP id 71699DDD04
	for <linuxppc-dev@ozlabs.org>; Sun,  7 Jun 2009 03:27:57 +1000 (EST)
Received: by yw-out-2324.google.com with SMTP id 2so1076101ywt.39
	for <linuxppc-dev@ozlabs.org>; Sat, 06 Jun 2009 10:27:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <9e4733910906060634k16a2dc6er138820e71cd2c6cf@mail.gmail.com>
References: <23901807.post@talk.nabble.com>
	<9e4733910906060634k16a2dc6er138820e71cd2c6cf@mail.gmail.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Sat, 6 Jun 2009 11:27:36 -0600
Message-ID: <fa686aa40906061027p41b8885aoda857a5a70a23762@mail.gmail.com>
Subject: Re: Missing some interrupts
To: Jon Smirl <jonsmirl@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, wael showair <showair2003@yahoo.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Jun 6, 2009 at 7:34 AM, Jon Smirl<jonsmirl@gmail.com> wrote:
> On Sat, Jun 6, 2009 at 9:17 AM, wael showair<showair2003@yahoo.com> wrote:
>>
>> Hi All,
>> i have a freescale board, that contains MPC8555 processor & DSP-core
>> there is a GPIO connecting the DSP-core into an input pin of the OpenPIC of
>> the MPC8555 processor.
>>
>> i test one interrupt from the DSP-core to the MPC8555 processor where i
>> configure this interrupt line to be edge-triggered (falling edge) & i
>> receive it successfully
>> but
>> when i generate this interrupt 10 successive times using for loop
>> i just receive 2 interrupts?
>>
>> why can't i receive the 8 other interrupts?
>> i print the value of every irq number inside do_IRQ & i found that i receive
>> the DSP-interrupt just only twice.
>>
>> do u have any suggestions to solve this problem?
>> i want to make sure that i can receive 10 interrupts
>
> Don't do a printk() with interrupts disabled. A printk() takes 1.5ms
> on a mpc5200.

Look at /proc/interrupts instead to see how many IRQs are received.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
