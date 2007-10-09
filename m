Return-Path: <THEMANN@de.ibm.com>
Received: from mtagate6.de.ibm.com (mtagate6.de.ibm.com [195.212.29.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate6.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C3C90DE047
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Oct 2007 18:21:22 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate6.de.ibm.com (8.13.8/8.13.8) with ESMTP id l998LGmS1681278
	for <linuxppc-dev@ozlabs.org>; Tue, 9 Oct 2007 08:21:16 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com
	[9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.5) with
	ESMTP id l998LG5E1786070
	for <linuxppc-dev@ozlabs.org>; Tue, 9 Oct 2007 10:21:16 +0200
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l998LFQc029719
	for <linuxppc-dev@ozlabs.org>; Tue, 9 Oct 2007 10:21:16 +0200
In-Reply-To: <adave9odqfb.fsf@cisco.com>
To: paulus@samba.org, jeff@garzik.org
MIME-Version: 1.0
Subject: Re: [PATCH 4/5] ibmebus: Move to of_device and of_platform_driver,
	match eHCA and eHEA drivers
Message-ID: <OF48E0997F.B61F7220-ONC125736F.002D7F06-C125736F.002DD3A7@de.ibm.com>
From: Jan-Bernd Themann <THEMANN@de.ibm.com>
Date: Tue, 9 Oct 2007 10:21:14 +0200
Content-Type: multipart/alternative;
	boundary="=_alternative 002DD3A6C125736F_="
Cc: Thomas Q Klein <tklein@de.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
	Paul Mackerras <pmac@au1.ibm.com>, Roland Dreier <rdreier@cisco.com>,
	Joachim Fenkes <fenkes@de.ibm.com>, LKML <linux-kernel@vger.kernel.org>,
	LinuxPPC-Dev <linuxppc-dev@ozlabs.org>,
	Christoph Raisch <raisch@de.ibm.com>,
	Stefan Roscher <stefan.roscher@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multipart message in MIME format.
--=_alternative 002DD3A6C125736F_=
Content-Type: text/plain; charset="US-ASCII"

Roland Dreier <rdreier@cisco.com> wrote on 03.10.2007 20:05:44:

>  > > Replace struct ibmebus_dev and struct ibmebus_driver with 
> struct of_device
>  > > and struct of_platform_driver, respectively. Match the external 
ibmebus
>  > > interface and drivers using it.
>  > > 
>  > > Signed-off-by: Joachim Fenkes <fenkes@de.ibm.com>
>  > 
>  > If not, then you need to get an Acked-by and an agreement that this
>  > change can go via the powerpc.git tree from Roland Dreier and Jeff
>  > Garzik.
> 
> I don't see anything objectionable in the infiniband parts of the
> patch -- I don't have any way to test the changes but it all looks
> like a straightforward conversion to a new platform API.  So:
> 
> Acked-by: Roland Dreier <rolandd@cisco.com>
> 
>  - R.

Looks good from eHEA driver perspective.

Acked-by: Jan-Bernd Themann <themann@de.ibm.com>
--=_alternative 002DD3A6C125736F_=
Content-Type: text/html; charset="US-ASCII"


<br><tt><font size=2>Roland Dreier &lt;rdreier@cisco.com&gt; wrote on 03.10.2007
20:05:44:<br>
<br>
&gt; &nbsp;&gt; &gt; Replace struct ibmebus_dev and struct ibmebus_driver
with <br>
&gt; struct of_device<br>
&gt; &nbsp;&gt; &gt; and struct of_platform_driver, respectively. Match
the external ibmebus<br>
&gt; &nbsp;&gt; &gt; interface and drivers using it.<br>
&gt; &nbsp;&gt; &gt; <br>
&gt; &nbsp;&gt; &gt; Signed-off-by: Joachim Fenkes &lt;fenkes@de.ibm.com&gt;<br>
&gt; &nbsp;&gt; <br>
&gt; &nbsp;&gt; If not, then you need to get an Acked-by and an agreement
that this<br>
&gt; &nbsp;&gt; change can go via the powerpc.git tree from Roland Dreier
and Jeff<br>
&gt; &nbsp;&gt; Garzik.<br>
&gt; <br>
&gt; I don't see anything objectionable in the infiniband parts of the<br>
&gt; patch -- I don't have any way to test the changes but it all looks<br>
&gt; like a straightforward conversion to a new platform API. &nbsp;So:<br>
&gt; <br>
&gt; Acked-by: Roland Dreier &lt;rolandd@cisco.com&gt;<br>
&gt; <br>
&gt; &nbsp;- R.</font></tt>
<br>
<br><tt><font size=2>Looks good from eHEA driver perspective.</font></tt>
<br>
<br><tt><font size=2>Acked-by: Jan-Bernd Themann &lt;themann@de.ibm.com&gt;</font></tt>
--=_alternative 002DD3A6C125736F_=--
