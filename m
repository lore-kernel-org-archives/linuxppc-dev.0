From: benh@kernel.crashing.org
To: Val Henson <val@nmt.edu>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Highmem on PPC?
Date: Tue, 5 Feb 2002 13:52:56 +0100
Message-Id: <20020205125256.16831@mailhost.mipsys.com>
In-Reply-To: <20020204183236.J3277@boardwalk>
References: <20020204183236.J3277@boardwalk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>What's the current state of highmem on the G4?  Does it work, not
>work, kinda work, only work on UP... ?
>
>I hope to have a dual 7450 G4 with 1 GB RAM within a week, at which
>point I'll be able to work on highmem seriously.

It's supposed to work. However, I'm having reports of dual 7450 with
1G or 1.5G of RAM locking up, I haven't been able to track those down.

Is this an Apple machine ? The 7450 has a bug that prevents use on
SMP with HW hash table walk. Apple is supposed to implement a HW
workaround for this on their machines, but if it's not an Apple machine,
then you may have to implement software TLB load.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
