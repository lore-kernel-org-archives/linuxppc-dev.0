Date: Fri, 23 May 2003 15:28:36 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: "David M?ller (ELSOFT AG)" <d.mueller@elsoft.ch>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: ERR51 / ERR77 on IBM405GPr
Message-ID: <20030523152836.B17219@home.com>
References: <3ECDF370.7020808@elsoft.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3ECDF370.7020808@elsoft.ch>; from d.mueller@elsoft.ch on Fri, May 23, 2003 at 12:09:52PM +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, May 23, 2003 at 12:09:52PM +0200, "David M?ller (ELSOFT AG)" wrote:
>
> Hello
>
> According to the errata sheet, the IBM405GPr doesn't suffer from the
> ERR51 / CPU_190 and ERR77 / CPU_210 bugs as the IBM405GP does.
>
> But the workarounds are still enabled in "arch/ppc/config.in".
>
> Shouldn't there be something like this:
>
>   if [ "$CONFIG_405GPR" = "y" ]; then
>     define_bool CONFIG_IBM405_ERR51 n
>     define_bool CONFIG_IBM405_ERR77 n
>   fi

I just committed something like this to 2_4_devel and will be moved to
the other trees as well.

--
Matt Porter
mporter@kernel.crashing.org

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
