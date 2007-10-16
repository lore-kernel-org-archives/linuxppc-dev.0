Return-Path: <fenkes@de.ibm.com>
Received: from mtagate6.uk.ibm.com (mtagate6.uk.ibm.com [195.212.29.139])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate6.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4C460DDE2E
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Oct 2007 00:20:36 +1000 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate6.uk.ibm.com (8.13.8/8.13.8) with ESMTP id l9GEKVOR119260
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Oct 2007 14:20:31 GMT
Received: from d06av02.portsmouth.uk.ibm.com (d06av02.portsmouth.uk.ibm.com
	[9.149.37.228])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v8.5) with
	ESMTP id l9GEKVn32789386
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Oct 2007 15:20:31 +0100
Received: from d06av02.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av02.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l9GEKPeY015586
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Oct 2007 15:20:25 +0100
From: Joachim Fenkes <fenkes@de.ibm.com>
To: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 4/5] ibmebus: Move to of_device and of_platform_driver,
	match eHCA and eHEA drivers
Date: Tue, 16 Oct 2007 23:20:00 +0200
References: <OF48E0997F.B61F7220-ONC125736F.002D7F06-C125736F.002DD39C@de.ibm.com>
In-Reply-To: <OF48E0997F.B61F7220-ONC125736F.002D7F06-C125736F.002DD39C@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200710162320.00630.fenkes@de.ibm.com>
Cc: Thomas Q Klein <tklein@de.ibm.com>, Jan-Bernd Themann <THEMANN@de.ibm.com>,
	netdev@vger.kernel.org, Paul Mackerras <pmac@au1.ibm.com>,
	LKML <linux-kernel@vger.kernel.org>,
	LinuxPPC-Dev <linuxppc-dev@ozlabs.org>,
	Christoph Raisch <raisch@de.ibm.com>, Marcus Eder <meder@de.ibm.com>,
	Paul Mackerras <paulus@samba.org>,
	Stefan Roscher <stefan.roscher@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 09 October 2007 10:21, Jan-Bernd Themann wrote:
> Roland Dreier <rdreier@cisco.com> wrote on 03.10.2007 20:05:44:
> >  > > Replace struct ibmebus_dev and struct ibmebus_driver with struct=20
of_device
> >  > > and struct of_platform_driver, respectively. Match the external=20
ibmebus
> >  > > interface and drivers using it.
> >  > >
> >  > > Signed-off-by: Joachim Fenkes <fenkes@de.ibm.com>
> >  >
> >  > This is somewhat difficult as this patch touches files that are the
> >  > responsibility of three different maintainers. =A0Is it possible to
> >  > split the patch into three, one for each maintainer (possibly by
> >  > keeping both old and new interfaces around for a little while)?
> >  >=20
> >  > If not, then you need to get an Acked-by and an agreement that this
> >  > change can go via the powerpc.git tree from Roland Dreier and Jeff
> >  > Garzik.
> >
> > I don't see anything objectionable in the infiniband parts of the
> > patch -- I don't have any way to test the changes but it all looks
> > like a straightforward conversion to a new platform API.  So:
> >
> > Acked-by: Roland Dreier <rolandd@cisco.com>
> >
> >  - R.
>
> Looks good from eHEA driver perspective.
>
> Acked-by: Jan-Bernd Themann <themann@de.ibm.com>

Jeff, do you have any objections against this patch going into the kernel
via Paul's powerpc.git tree? It touches only a few lines of ehea which are
specific to the bus interface changes.

You can see the full patch here:
  http://patchwork.ozlabs.org/linuxppc/patch?id=3D13750

If you have no objections, please ack the patch so Paul can include it.

Thanks and regards,
  Joachim
