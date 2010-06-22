Return-Path: <chuck@ThePTRGroup.com>
Received: from mail.theptrgroup.com (mail.theptrgroup.com [71.178.251.9])
	by ozlabs.org (Postfix) with ESMTP id 18D40B6F16
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 23 Jun 2010 01:15:26 +1000 (EST)
Received: from [10.11.13.50] (unknown [10.11.13.50])
	by mail.theptrgroup.com (Postfix) with ESMTP id C8CF71E002
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 22 Jun 2010 11:15:24 -0400 (EDT)
Message-ID: <4C20D386.2000506@ThePTRGroup.com>
Date: Tue, 22 Jun 2010 11:15:18 -0400
From: Chuck Meade <chuck@ThePTRGroup.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: UCC interactions
References: <4C1FB6BB.4040705@mlbassoc.com>
	<AANLkTinyt8phAgxJk30G0XuA5kJ78Xy1WdTg_yQpTCsS@mail.gmail.com>
In-Reply-To: <AANLkTinyt8phAgxJk30G0XuA5kJ78Xy1WdTg_yQpTCsS@mail.gmail.com>
Content-Type: text/plain; charset=iso-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/22/2010 10:51 AM, Timur Tabi wrote:
> On Mon, Jun 21, 2010 at 2:00 PM, Gary Thomas <gary@mlbassoc.com> wrote:
>> I'm running 2.6.33.3 on MPC8358.  I have UCC1+UCC2 working fine
>> for ethernet, but when I add UCC3 as a UART, the network devices
>> quit working.
> 
> Since you're using QE UART, would you mind testing this patch:
> 
> http://patchwork.ozlabs.org/patch/56181/
> 
> and letting us know if it works for you?
> 

Hi Timur,

His UART is not working yet.  I am fine with him testing my patch (I hope he does),
just he still is working on getting his UART to work at all.  I think since he is
using MPC8358, he needs the soft UART mode microcode patch.

The patch that you mention above is one I wrote that affects how the UART close
operation handles being closed when buffered output is still present.  I fixed the
timeout so it closes in the correct amount of time.  Gary is not quite ready for
testing this yet.

Thanks,
Chuck
