From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stefan Berndtsson <stefan@nocrew.org>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: 2.4.3 on Lombard
Date: Mon, 2 Apr 2001 18:14:19 +0200
Message-Id: <20010402161419.3072@mailhost.mipsys.com>
In-Reply-To: <87r8zbmj5k.fsf@hades.nocrew.org>
References: <87r8zbmj5k.fsf@hades.nocrew.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>I tried compiling 2.4.3 (rsync from penguinppc.org::linux-2.4-benh) on
>my Lombard, with a very similar setup to the 2.4.0 I'm currently running.
>It hung in the early boot stage, so I disabled the early boot text thing,
>and then the firmware prints:
>
>... ok
>copying OF device tree...done
>Calling quiesce ...
>returning 01400000  from prom_init
>
>At this point it hangs indefinitely.
>
>2.4.0 (older rsync from linuxppc.org::linux-pmac-devel) boots just fine
>on the same hardware.
>
>I have no idea what to try now. .config can be found at:
>
>http://stefan.nocrew.org/config-2.4.3
>
>...and the older kernel config at:
>
>http://stefan.nocrew.org/config-2.4.0

Looks like a generic problems on pre-core99 machines with all the latest
2.4.3's,
I'm investigating.

ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
