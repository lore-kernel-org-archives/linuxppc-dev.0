From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stefan Jeglinski <jeglin@4pi.com>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: ethtool failure with tulip 21143
Date: Mon, 17 Dec 2001 00:38:53 +0100
Message-Id: <20011216233853.23752@smtp.wanadoo.fr>
In-Reply-To: <p04330101b842de27485b@[24.163.44.170]>
References: <p04330101b842de27485b@[24.163.44.170]>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>A long time ago (2.2.13 or so), I could not use another card on the
>6500 for very long with the de4x5 driver as well. At that time, Paul
>provided a patch for the de4x5 driver which fixed the problem. He
>also described the issue as a cache coherency problem.

Yes, paul's patch is what I'm talking about.

>Well, I wonder if that was the fix that Paul put in. Some time ago
>(early 2.4) I tried the de4x5 driver with this Farallon 10/100 card
>but it worked even more poorly than the tulip driver of that time did.

Yup.
>
>>Try defining CACHE_ALIGN to CAL_32LONG, and DESC_ALIGN to u32 dummy[4]
>>(as in the commented out example).
>
>I will look at the de4x5 code again and try this. It's all vaguely
>familiar to me... Thanks much!

That should be the same patch paul did.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
