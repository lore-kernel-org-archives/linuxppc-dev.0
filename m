Subject: Re: MPC860SAR question
From: Alex Zeffertt <ajz@cambridgebroadband.com>
To: li <slowforce@21cn.com>
Cc: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <AC969374764690.16974@webmail5.inner-21cn.com>
References: <AC969374764690.16974@webmail5.inner-21cn.com>
Content-Type: text/plain
Message-Id: <1056559553.2827.394.camel@zambia.cambridgebroadband.com>
Mime-Version: 1.0
Date: 25 Jun 2003 17:45:53 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Li,

By default the driver uses the ESAR interface (and assumes the firmware
supports it).  All mpc860s support the original SAR interface.  If you
want to use this instead just uncomment the line

	#define GOT_ESAR

in mpc860sar.c

Alex

On Wed, 2003-06-25 at 16:53, li wrote:
> Hi all,
> Does anybody know about if the mpc860sar has an Enhanced SAR?
> Regards!
> Li
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
