Message-ID: <38BB59CD.15A69DD9@chpc.utah.edu>
Date: Mon, 28 Feb 2000 22:31:58 -0700
From: Lou Langholtz <ldl@chpc.utah.edu>
MIME-Version: 1.0
To: phandel@cise.ufl.edu
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Powerbook code in 2.3.x [was Re: problem building 2.3.47:
 nomacintosh.a file]
References: <Pine.LNX.4.21.0002282145380.14383-100000@adsl-78-160-189.gnv.bellsouth.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


phandel@cise.ufl.edu wrote:

> On Mon, 28 Feb 2000, Lou Langholtz wrote:
>
> > undefined references are to: find_via_pmu, pmu_poll, backlight_level,
> > pmu_set_brightness, and vgacon_remap_base.
>
> This is because there is Powerbook code without #ifdef CONFIG_PMAC_PBOOK
> around it.  Here is a quick patch: . . .

Thanks. This seems like a far better fix than what I wound up doing: just setting
CONFIG_ADB_PMU=y (I have a PowerMac 7500 not a Powerbook after all) and I'm gonna
recompile with your fix instead. So now I'm wondering how many people (if any) are
actually running 2.3.47 from kernel.org and happy with it especially for a
PowerMac7500. Thanks!


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
