From: Paul Mackerras <paulus@linuxcare.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <14782.63504.101500.256357@argo.linuxcare.com.au>
Date: Wed, 13 Sep 2000 14:44:16 +1100 (EST)
To: mlan@cpu.lu
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: sysctl support for ICTC
In-Reply-To: <200009122127.XAA00922@piglet.grunz.lu>
References: <20000912205547.30777@192.168.1.10>
	<200009122127.XAA00922@piglet.grunz.lu>
Reply-To: paulus@linuxcare.com.au
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michel Lanners writes:

> In the idle task, the processor (if supporting sleep) is put to either
> NAP or DOZE mode (see arch/ppc/kernel/idle.c). NAP mode seems to save
> more power, but there's no snooping. Don't know whether that would be a
> problem... but I guess it could. Anyway, if somebody wants to
> experiment, NAP can be enabled with
> /proc/sys/kernel/powersave-nap.

When I tried on my 1999 G3 powerbook, it seemed to be that it used
more power in nap mode than in doze mode, so I leave it in doze mode.

Paul.

--
Paul Mackerras, Senior Open Source Researcher, Linuxcare, Inc.
+61 2 6262 8990 tel, +61 2 6262 8991 fax
paulus@linuxcare.com.au, http://www.linuxcare.com.au/
Linuxcare.  Support for the revolution.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
