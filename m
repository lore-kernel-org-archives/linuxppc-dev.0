Subject: Re: [PATCH] cpufreq support for 7447A on 2004 iBooks
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: John Steele Scott <toojays@toojays.net>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>,
	Christiaan Welvaart <cjw@daneel.dyndns.org>, cpufreq@www.linux.org.uk
In-Reply-To: <200406051846.50718.toojays@toojays.net>
References: <200406051846.50718.toojays@toojays.net>
Content-Type: text/plain
Message-Id: <1086452473.12664.36.camel@gaston>
Mime-Version: 1.0
Date: Sat, 05 Jun 2004 11:21:14 -0500
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 2004-06-05 at 04:15, John Steele Scott wrote:
>
> Okay, thanks to some tips from Benjamin Herrenschmidt, I now have a patch
> against 2.6.6 which lets you control dynamic frequency scaling on the latest
> model iBook G4. I imagine that this same method would apply to the new
> PowerBooks as well.

I suggest you also look at the latest Darwin code Apple released, more
sepecifically AppleMacRISC2PE. There is some new bits including something
about tweaking a bus delay when changing the frequency on these models.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
