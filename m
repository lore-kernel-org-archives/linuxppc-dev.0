Message-ID: <3C838533.6050603@pacbell.net>
Date: Mon, 04 Mar 2002 14:31:15 +0000
From: Armin <akuster@pacbell.net>
MIME-Version: 1.0
To: andrew may <acmay@acmay.homeip.net>
Cc: John Tyner <jtyner@cs.ucr.edu>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: [PATCH] ocp enet
References: <Pine.LNX.4.30.0202271525500.15001-200000@hill.cs.ucr.edu> <3C7D0AB9.5070801@pacbell.net> <20020304131703.A15551@ecam.san.rr.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


andrew may wrote:
> On Wed, Feb 27, 2002 at 04:35:05PM +0000, Armin wrote:
>
>>Thanks,
>>
>>I want to try in on a few boards I have before it goes in.
>>
>>--armin
>>
>
> Have you gotten a chance to try it yet? The testing I have
> done has not shown any problems and I have been able to test
> just about all of the cases. Boards with/without the correct
> pull-ups. Remove the correct phy-id from the table. Booting
> without a link.
>
> Here is another patch that for the driver. It removes some
> cut and paste code from the rx interupts and breaks the work
> into rx_clean and rx_fill functions. rx_fill is also called from
> open.
>


Yes I have.

I added history info and sent it to Tom to check in.

I will look into this patch and will try it after Tom gets done.

armin


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
