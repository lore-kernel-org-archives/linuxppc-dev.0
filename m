To: linuxppc-dev@lists.linuxppc.org
From: Igal Baevsky <igal.baevsky@terayon.com>
Subject: Re: pmac_halt() bug
Date: Mon, 10 Nov 2003 18:33:09 +0200
Message-ID: <booek6$vvl$1@sea.gmane.org>
References: <7AFDCF4E-FCCB-11D6-8F24-003065F22EAA@mindspring.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
In-Reply-To: <7AFDCF4E-FCCB-11D6-8F24-003065F22EAA@mindspring.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Tim Seufert wrote:
>
> In platforms/pmac_setup.c, pmac_halt() is defined as follows:
>
> pmac_halt(void)
> {
>     pmac_power_off();
> }
>
> Arguably, this is a bug because there should be a distinction between
> halt and poweroff.  I've seen posts on user mailing lists from at least
> two different people who want to halt without actually powering off,
> but cannot do so because of this bug.  (I think the reasons have
> something to do with attempting to get their machines to turn back on
> automatically when power is restored after a UPS-initiated shutdown.)
>
>
>
>

Tim,
Is there any way to halt PMAC machine with no powering it off ?
I will realy appretiate your answer - the problem you mentioned above is
the exact problem I'm dealing with .
Thanks.
Igal


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
