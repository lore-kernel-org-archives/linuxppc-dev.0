From: benh@kernel.crashing.org
To: Christopher Murtagh <christopher.murtagh@mcgill.ca>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: SMP/HIGHMEM/7450 status ?
Date: Thu, 6 Jun 2002 07:37:12 +0200
Message-Id: <20020606053712.8506@mailhost.mipsys.com>
In-Reply-To: <Pine.LNX.4.33.0206061134150.20358-100000@blues.wcg.mcgill.ca>
References: <Pine.LNX.4.33.0206061134150.20358-100000@blues.wcg.mcgill.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> I was wondering if anyone has had any luck with the 7450 with SMP and
>HIGHMEM recently. There were problems with it in the past, and I was
>wondering if any fixes have been included in the current
>source.mvista.com::linuxppc_2_4 rsync tree. The reason why I ask is
>because the only dual 7450 machine I have is currently in production and I
>can't do any testing on it, and I need to turn on the second CPU some
>time soon.
>
> Any info would be much appreciated.

Well... It sorta works until you put really high load on it, then
usually, a CPU locks up in an unrecoverable way. We haven't yet been
able to find a workaround.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
