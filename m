Date: Wed, 21 Nov 2001 11:59:54 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: linuxppc-dev@lists.linuxppc.org,
	Paul Mackerras <paulus@samba.org>
Cc: linuxppc-commit@source.mvista.com
Subject: Re: Incoming to hostme.bitkeeper.com:/ua/repos/p/ppc/linuxppc_2_4_devel
Message-ID: <20011121115954.I3436@cpe-24-221-152-185.az.sprintbbd.net>
References: <20011121185116.6539A100D1@hostme.bitkeeper.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20011121185116.6539A100D1@hostme.bitkeeper.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Nov 21, 2001 at 10:51:16AM -0800, ppc@bitkeeper.com wrote:

> ChangeSet@1.682, 2001-11-21 11:39:42-07:00, trini@opus.bloom.county
>   Re-implement passing the System.map into the chrp wrapper if CONFIG_XMON.
>   Currently we always add in the map if CONFIG_XMON, but we could make even
>   this conditional.

I have this done but untested on pmac.  The problem is that on
'coffboot' we specify not only a link address for .text but for .data as
well, and with a System.map in the .rodata, these locations overlap.
Does anyone know why we do -Ttext 500000 -Tdata 510000 for coffboot?  Is
there a certain alignment we have to keep?

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
