Date: Thu, 1 Apr 2004 19:50:28 -0900
From: Ethan Benson <erbenson@alaska.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: arch/ppc/Makefile wiping out /dev/null
Message-ID: <20040402045027.GG21226@plato.local.lan>
References: <20BB0EB5-841D-11D8-9FF0-000A95A07384@sands-edge.com>
Mime-Version: 1.0
In-Reply-To: <20BB0EB5-841D-11D8-9FF0-000A95A07384@sands-edge.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Apr 01, 2004 at 03:42:44PM -0500, John Whitney wrote:
>
> NEW_AS := $(shell echo dssall | $(AS) -o /tmp/.as.$$$$ >/dev/null 2>&1
> ; echo $$?)

depending on the behavior of $(AS) this is not secure.

--
Ethan Benson
http://www.alaska.net/~erbenson/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
