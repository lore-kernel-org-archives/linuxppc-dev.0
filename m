Subject: Re: NULL-pointer dereference in ELF core dump, and proposed fix
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: John Whitney <john.whitney@timesys.com>
Cc: "Mailing List: linuxppc-dev" <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <BC0DBF6B.3126%john.whitney@timesys.com>
References: <BC0DBF6B.3126%john.whitney@timesys.com>
Content-Type: text/plain
Message-Id: <1072237883.699.34.camel@gaston>
Mime-Version: 1.0
Date: Wed, 24 Dec 2003 14:51:23 +1100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> if (last_task_used_math == current)
>     giveup_fpu (current);
>
> Anyone see any problems with this change?

last_task_used_math doesn't exist on SMP

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
