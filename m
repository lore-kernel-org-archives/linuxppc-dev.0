From: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
To: "Segher Boessenkool" <segher@koffie.nl>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: Re: RFC: Performance Monitor Counters device
Date: Mon, 16 Sep 2002 14:38:07 +0200
Message-Id: <20020916123807.15088@192.168.4.1>
In-Reply-To: <3D831D5A.BF11BC0D@koffie.nl>
References: <3D831D5A.BF11BC0D@koffie.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>It does not exist on 7450 etc.
>It exists on 7410 before version 1.3 .
>I have no data on 7400.
>It does not exist on 750 etc.
>
>[As my only G4 is a 7410 version 1.3, I won't be affected by this.  Hurray.]

I had it happening on 7400.

>The problem itself: if two of thermal assist, decrementer, performance
>monitor interrupts happen within 1 cycle of each other, evil things
>happen with SRR0 and SRR1, so that the return address becomes
>unrecoverable.
>
>Suggested solution:
>
>We can forget about thermal assist, as the TAU on all 74xx is broken
>and unsupported.  (Says those same errata sheets).
>If necessary, it's possible to disable the decrementer interrupt and have
>the performance monitor perform its function.
>
>But I won't run into this, so I'm happy for now :)

We can't disable the DEC that easily as it's the primary timer
source of the kernel ;)

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
