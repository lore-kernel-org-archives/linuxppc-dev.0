Return-Path: <eemingliu@hotmail.com>
Message-ID: <BAY138-F400F2CE580BD3EB48B9A3CB2DC0@phx.gbl>
In-Reply-To: <20070813093107.GG13994@moe.telargo.com>
From: "Ming Liu" <eemingliu@hotmail.com>
To: domen.puncer@telargo.com
Subject: Re: basic and stupid question on wait_event and wake_up
Date: Mon, 13 Aug 2007 09:46:17 +0000
Mime-Version: 1.0
Content-Type: text/plain; charset=gb2312; format=flowed
Cc: Linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Thank you so much for your explanation. Now I am quite clear on this topic. 


Domen, Sorry for my misspelling of your name. That should be "Domen" not 
"Momen". Sorry for that. :)

BR
Ming


>From: Domen Puncer <domen.puncer@telargo.com>
>To: Ming Liu <eemingliu@hotmail.com>
>CC: Linuxppc-embedded@ozlabs.org
>Subject: Re: basic and stupid question on wait_event and wake_up
>Date: Mon, 13 Aug 2007 11:31:07 +0200
>
>On 13/08/07 09:22 +0000, Ming Liu wrote:
> > Dear Momen,
> > OK. I see now. So you mean condition is only to judge whether a 
sleeping
> > process could be waken up or not when wake_up() is executed in other
> > processes or interrupt handlers. What really wakes the process up is 
still
> > the function of wake_up, right? We just execute wake_up() and then 
check if
> > condition is true. If yes, the process will leave its sleeping and wake 
up;
> > if not, it keep sleeping. Am I right?
>
>Right.
>
>
>	Domen

_________________________________________________________________
√‚∑—œ¬‘ÿ MSN Explorer:   http://explorer.msn.com/lccn/  
