From: benh@kernel.crashing.org
To: Ethan Benson <erbenson@alaska.net>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: DST flag in NVRAM revisited (was: Re: NVRAM stuck in DST?)
Date: Thu, 28 Mar 2002 18:18:59 +0100
Message-Id: <20020328171859.4716@mailhost.mipsys.com>
In-Reply-To: <20020328040442.V26309@plato.local.lan>
References: <20020328040442.V26309@plato.local.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>we should just deal with the RTC exactly how its delt with on x86, if
>you have windows (or in our case MacOS) you tell hwclock the RTC is in
>localtime and let it deal with it, if you don't have MacOS/windows you
>tell it you have the RTC in GMT like its supposed to be and all is well.

Which means that during boot, the kernel will have a wrong (local) time
instead of UTC. That can be annoying.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
