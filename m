Date: Thu, 22 Jul 2004 12:48:10 +0200
From: Guido Guenther <agx@sigxcpu.org>
To: Rob Weir <rweir@ertius.org>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: pmdisk oops(?) on g4 ibook
Message-ID: <20040722104810.GB11423@bogon.ms20.nix>
References: <20040701041703.GH27929@ooder.ertius.org> <20040716074152.GC3698@bogon.ms20.nix> <20040716082310.GB4608@ooder.ertius.org> <20040716092003.GE3698@bogon.ms20.nix> <20040716094049.GC4608@ooder.ertius.org>
Mime-Version: 1.0
In-Reply-To: <20040716094049.GC4608@ooder.ertius.org>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Jul 16, 2004 at 07:40:49PM +1000, Rob Weir wrote:
> I do a dist-upgrade against sid every few days, but I haven't changed
> the kernel in weeks. Hm...I'm using your 2.6.7-rc3 pmdisk patch
> against 2.6.7 itself, maybe I should just update to your 2.6.7 one and
> 2.6.8-rcX before bothering you further...

Just for completeness: we tracked this down do be CONFIG_PREEMPT
related. Without that it works fine on 2.6.8-rc2.
Cheers,
 -- Guido

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
