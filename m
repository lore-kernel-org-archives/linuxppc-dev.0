Date: Fri, 24 May 2002 20:09:53 -0700
From: Matt Porter <porter@cox.net>
To: Rajappa Iyer <rsi@panix.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: P2P bridge (DEC 21154) initialization on MCP750
Message-ID: <20020524200953.A21781@home.com>
References: <200205250114.g4P1ELi08721@panix1.panix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200205250114.g4P1ELi08721@panix1.panix.com>; from rsi@panix.com on Fri, May 24, 2002 at 09:14:21PM -0400
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, May 24, 2002 at 09:14:21PM -0400, Rajappa Iyer wrote:
>
> I'm having problems with the PCI-PCI bridge (DEC 21154) on the MCP750
> and would appreciate any words of wisdom.  Basically, this bridge does
> not get initialized and therefore no devices are probed on the
> secondary bus.
>
> I've tried all three kernel trees from source.mvista.com
> (linuxppc_2_4, linuxppc_2_4_devel and linuxppc_2_5).  The devel branch
> does not get past the Bogomips calibration loop.  The other two do not
> initialize the bridge.
>
> Any ideas on how to fix this?

Use _devel and start with the pplus port.  'make pplus_config'
Although code still exists for the PowerPlus architecture
boards within the legacy PReP port, it isn't maintained for
those boards (except maybe for MTX).

Regards,
--
Matt Porter
porter@cox.net
This is Linux Country. On a quiet night, you can hear Windows reboot.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
