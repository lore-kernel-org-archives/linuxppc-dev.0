Subject: Re: how to setup PLL1 on 750FX
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Chris Studholme <cvs@cs.utoronto.ca>
Cc: Terry Greeniaus <tgree@phys.ualberta.ca>,
	linuxppc-dev@lists.linuxppc.org
In-Reply-To: <Pine.LNX.4.44.0306272254160.14332-100000@stoa.dhs.org>
References: <Pine.LNX.4.44.0306272254160.14332-100000@stoa.dhs.org>
Content-Type: text/plain
Message-Id: <1056788580.32105.82.camel@gaston>
Mime-Version: 1.0
Date: 28 Jun 2003 10:23:01 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 2003-06-28 at 05:05, Chris Studholme wrote:

> My patch is now working quite well for me.  I've got cpufreq working and
> I've verified that the cpu speed actually drops to about half when low
> speed is selected.  I've also modified the patch so the bulk of the code
> is selectable by a config option (CONFIG_BLUECHIP_750FX).  I've included
> the full patch below.  Let me know if you would like any changes to make
> this patch more acceptable for the main linuxppc trees.  Thanks for all
> the help getting this working.

Looks good. Just fix the cpu_setup_6xx.S code so that sleep mode
works properly and it should be ok to merge upstream.

Ben.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
