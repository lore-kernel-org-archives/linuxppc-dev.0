From: benh@kernel.crashing.org
To: Christopher Murtagh <christopher.murtagh@mcgill.ca>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: SMP/HIGHMEM/7450 status ?
Date: Thu, 6 Jun 2002 08:08:12 +0200
Message-Id: <20020606060812.19068@mailhost.mipsys.com>
In-Reply-To: <Pine.LNX.4.33.0206061217470.20358-100000@blues.wcg.mcgill.ca>
References: <Pine.LNX.4.33.0206061217470.20358-100000@blues.wcg.mcgill.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>Well... It sorta works until you put really high load on it, then
>>usually, a CPU locks up in an unrecoverable way. We haven't yet been
>>able to find a workaround.
>
> Ouch. Thanks for the speedy response Ben. This doesn't look so good for
>Terra Soft if they want to be an OEM for the Xserve.

Xserve uses 7455 (like newer dual G4s), which doesn't seem to exhibit the
problem.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
