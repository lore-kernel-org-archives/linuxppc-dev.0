Date: Sat, 17 Jan 2004 10:41:48 +0100
From: Colin Leroy <colin@colino.net>
To: valvoline@vrlteam.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] therm_* drivers need i2c-keywest
Message-Id: <20040117104148.6af58e88.colin@colino.net>
In-Reply-To: <20040116164430.GV2658@adapter.n0skillz.org>
References: <20040116122756.034fc736.colin@colino.net>
	<20040116164430.GV2658@adapter.n0skillz.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On 16 Jan 2004 at 17h01, valvoline wrote:

Hi,

> what's about /dev/ entries ?, i still see nothing into it...the only infos
> that i can fetch are into /var/log/syslog.
>
> If i don't make a mismatch, there should be some /dev entries that the
> module should create, usefull to set/fetch important informations about
> fans/cpu.

They're in /sys - that's the new 2.6 location for such things.
Look in /sys/devices/temperatures/

--
Colin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
