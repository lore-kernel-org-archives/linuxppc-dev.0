From: Graham Stoney <greyham@research.canon.com.au>
To: "john zhan" <johnzhan@btamail.net.cn>,
        "john zhan" <johnzhan@btamail.net.cn>,
        <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: GDB for host development platform
Date: Mon, 13 Nov 2000 10:50:35 +1100
Content-Type: text/plain
Cc: "Daris A Nevil" <dnevil@snmc.com>,
        "Cal Erickson" <cal_erickson@mvista.com>
References: <006001bf448c$4aee3aa0$57c809c0@fel> <3A0BFE46.A7366165@snmc.com> <00c401c04bb1$dbf78420$57c809c0@fel>
In-Reply-To: <00c401c04bb1$dbf78420$57c809c0@fel>
MIME-Version: 1.0
Message-Id: <00111310543400.25219@brixi>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Sat, 11 Nov 2000, john zhan wrote:
> So,I hope GDB can work with exec-file target in a standalone
> linux/ppc machine.
> It is the worst news that GDB is not ready for linux/ppc exec-file target.

I believe you are doing something wrong; probably you have configured gdb
wrongly.  Certainly there are many people using gdb natively on powerpc-linux,
and many others using it in cross-development environments.  I've done both
successfully .  It sounds like yours is configured for cross-development, but
you're trying to use it native. What parameters did you pass to configure?

(And while I'm here, why are you using the old gdb-4.18 rather than gdb-5.0?)

Regards,
Graham
--
Graham Stoney
Assistant Technology Manager
Canon Information Systems Research Australia
Ph: +61 2 9805 2909  Fax: +61 2 9805 2929

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
