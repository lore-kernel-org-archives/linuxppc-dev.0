Message-ID: <3C84A33A.30700@pacbell.net>
Date: Tue, 05 Mar 2002 10:51:38 +0000
From: Armin <akuster@pacbell.net>
MIME-Version: 1.0
To: andrew may <acmay@acmay.homeip.net>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: [PATCH] ocp enet
References: <Pine.LNX.4.30.0202271525500.15001-200000@hill.cs.ucr.edu> <3C7D0AB9.5070801@pacbell.net> <20020304131703.A15551@ecam.san.rr.com> <3C838533.6050603@pacbell.net> <20020304195328.B15551@ecam.san.rr.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


andrew may wrote:

>
> Well I just noticed that building as a module is pretty far from
> working at the moment. Are there any plans to fix this?

Havn't thought about it but sound like it needs to addressed.

> I am not
> sure how to cleanly get this working since there are all sorts of
> exports/externs that need to be fixed up.

I can add it to my TODO list unless you need it asap?

> I
> don't know if we want to do this for the ocp_enet as well.
>
fine with me.

> I can resend with a .h change and config.in change to pull the
> skb_res value out as a build option, but I want to see if anyone
> has any other comments before hand.
>
fine

-armin


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
