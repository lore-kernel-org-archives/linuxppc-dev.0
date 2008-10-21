Return-Path: <jbarnes@virtuousgeek.org>
Received: from outbound-mail-38.bluehost.com (outbound-mail-38.bluehost.com
	[69.89.20.192]) by ozlabs.org (Postfix) with SMTP id A826ADDDF0
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Oct 2008 09:58:40 +1100 (EST)
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: benh@kernel.crashing.org
Subject: Re: [RFC/PATCH] pci: Workaround invalid P2P bridge bus numbers
Date: Tue, 21 Oct 2008 15:58:33 -0700
References: <20081020230717.2FD16DDDDB@ozlabs.org>
	<16691A8B34B5D9458EA3A1C37A11555A0137F833@tanisys-ex2.Tanisys.Local>
	<1224628380.7654.277.camel@pasglop>
In-Reply-To: <1224628380.7654.277.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200810211558.34192.jbarnes@virtuousgeek.org>
Cc: Ayman El-Khashab <AymanE@tanisys.com>, linux-pci@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday, October 21, 2008 3:33 pm Benjamin Herrenschmidt wrote:
> On Tue, 2008-10-21 at 09:36 -0500, Ayman El-Khashab wrote:
> > > Ayman, can you double check that this variant of the patch still
> > > fixes your problem ? Thanks !
> >
> > I've tried it out and it is working correctly with my devices.  The
> > subordinate bus numbers on all the ports are correct.
>
> Thanks !

Great, pushed to linux-next.

Thanks,
Jesse
