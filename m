Mime-Version: 1.0
Message-Id: <p04330109b640a43ed53d@[206.6.156.5]>
In-Reply-To: <200011212148.WAA00753@piglet.grunz.lu>
References: <200011212148.WAA00753@piglet.grunz.lu>
Date: Tue, 21 Nov 2000 17:17:41 -0500
To: mlan@cpu.lu
From: Stefan Jeglinski <jeglin@4pi.com>
Subject: Re: whacked out 2.2.18preX - last gasp
Cc: linuxppc-dev@lists.linuxppc.org
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>  > _2_5 will help configs with multiple PCI busses except for IO ports which
>>  will still be available on the first bus only. This may get fixed for PCI
>>  IO BARs if we end up mapping virtually all the IO spaces appended together.
>
>... which prompts me to ask: have you tried the 2940 in the three upper
>     slots _and_ in the three lower slots? Same result both times?


No, Ben had same Q, I tried the 2940 in only 3 slots last night
(dunno why I didn't, just got tired of it I guess). With renewed
vigor, will do all 6 tonight and let y'all know.



Stefan Jeglinski

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
