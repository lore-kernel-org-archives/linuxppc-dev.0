Date: Thu, 28 Nov 2002 20:31:13 -0900
From: Ethan Benson <erbenson@alaska.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: [patch] ignore trackpad/mouse while typing
Message-ID: <20021129053113.GB6329@plato.local.lan>
References: <3DE6C428.5000403@TU-Berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3DE6C428.5000403@TU-Berlin.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Nov 28, 2002 at 05:34:32PM -0800, Till Straumann wrote:
>
>     /proc/sys/dev/input/mouse_holdoff_ms
>
> for tuning the time period during which the mouse is to
> be ignored after a keystroke (valid range from
> 0 [disabled]  ... 3000 ).
>
> NOTE: Official 'SYSCTL' numbers should be assigned
>       for the 'input' and 'input/mouse_holdoff_ms' nodes.

why didn't you just use the mac_hid/ node to hold your
mouse_holdoff_ms node?

--
Ethan Benson
http://www.alaska.net/~erbenson/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
