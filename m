Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2C95DDDFAF
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Apr 2009 16:44:42 +1000 (EST)
Message-Id: <43350B71-1FBE-436E-81A7-E4043132E629@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Vijay Nikam <vijay.t.nikam@gmail.com>
In-Reply-To: <f234e2140904062329i48630711safdedf786ab7f0c6@mail.gmail.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: Bug:scheduling while atomic
Date: Tue, 7 Apr 2009 01:42:02 -0500
References: <f234e2140904062329i48630711safdedf786ab7f0c6@mail.gmail.com>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 7, 2009, at 1:29 AM, Vijay Nikam wrote:

> Hello All,
>
> I have mpc8313erb with linux kernel 2.6.20.
>
> When I ported the kernel with CONFIG_PREEMPT=y (Enabled) I am getting
> the 'scheduling while atomic'. Please check the following call trace,
> thanks.
>
> Could anyone please let me to the way to fix it ? ? ?
>
> Kindly please acknowledge ... thank you ...
>
> Kind Regards,
> Vijay Nikam

Have you tried a newer kernel (like 2.6.29) and see if the issue still  
exists.

- k
