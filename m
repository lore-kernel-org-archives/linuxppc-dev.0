Date: Thu, 21 Sep 2000 13:22:40 -0700
From: Matt Porter <mporter@mvista.com>
To: Dan Malek <dan@mvista.com>
Cc: paulus@linuxcare.com.au,
        Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: __ioremap_at() in 2.4.0-test9-pre2
Message-ID: <20000921132240.F13197@cx258813-a.chnd1.az.home.com>
References: <14790.58502.25252.825448@argo.linuxcare.com.au> <20000919150621.A9826@cx258813-a.chnd1.az.home.com> <14791.61311.118516.747495@argo.linuxcare.com.au> <39C8DE1A.BC8EF0B6@mvista.com> <14793.18115.38314.912204@argo.linuxcare.com.au> <39C96EBC.6BE23535@mvista.com> <14793.29680.948198.119368@argo.linuxcare.com.au> <39C98739.B3656E8F@mvista.com> <14793.38735.809789.111193@argo.linuxcare.com.au> <39C9AFE2.25CB0ADA@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <39C9AFE2.25CB0ADA@mvista.com>; from dan@mvista.com on Thu, Sep 21, 2000 at 02:51:14AM -0400
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Sep 21, 2000 at 02:51:14AM -0400, Dan Malek wrote:
>
> I actually think we are in nearly violent agreement, and I am getting
> way too tired tonight to continue much further.....
>
> Paul Mackerras wrote:
> > We could do that too, we would just have to make sure that we assigned
> > PCI I/O addresses so that no two bridges had devices in the same 4k
> > range, then we could set up the virtual->physical mapping to give the
> > illusion of a single I/O space.
>
> I think we agree that we just use the PCI bridges to the best of
> their ability, and let the MMU do the reset.  There are combinations
> of this that are more efficient on some systems that others.  I have
> no illusion of requiring a single I/O space (that's what MMUs are for :-).

I think that for a lot of bridges we won't have to have the MMU do
the heavy lifting.  Now that I understand the virtual mapping approach
better I'm in agreement.

--
Matt Porter
MontaVista Software, Inc.
mporter@mvista.com

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
