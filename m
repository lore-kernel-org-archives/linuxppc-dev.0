Return-Path: <vbarshak@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id A3DA7DE119
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Apr 2009 06:04:31 +1000 (EST)
Message-ID: <49F0C9D7.1070707@ru.mvista.com>
Date: Fri, 24 Apr 2009 00:04:39 +0400
From: Valentine <vbarshak@ru.mvista.com>
MIME-Version: 1.0
To: "Steven A. Falco" <sfalco@harris.com>
Subject: Re: [PATCH] PowerPC: 440EPx/GRx Sequoia/Rainier U-Boot incorrect
	chipselect number workaround
References: <20090423171222.GA32326@ru.mvista.com>
	<49F0A957.5080508@harris.com>
In-Reply-To: <49F0A957.5080508@harris.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, sr@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Thanks Steven,
Yes, both patches have to be applied.
Sorry, I missed a trailing space in the comment.
I'll resubmit another one in a bit.
Thanks,
Val.

Steven A. Falco wrote:
> 
> Thanks for doing this so quickly!
> 
> I applied your patch plus my patch - my custom board reports
> the correct memory size.  Therefore,
> 
> Acked-by: Steven A. Falco <sfalco@harris.com>
> 
> Clearly, both your and my patches must be applied together or
> "bad things will happen".
> 
> BTW, I got a whitespace warning when applying your patch:
> 
> Applying: PowerPC: 440EPx/GRx Sequoia/Rainier U-Boot incorrect chipselect number workaround
> /proj/hydra/sw/sfalco/linux-2.6-denx/.git/rebase-apply/patch:17: trailing whitespace.
>  * hardwired. Hardcode the number of chipselects to one
> warning: 1 line adds whitespace errors.
> 
> 	Steve
> 
