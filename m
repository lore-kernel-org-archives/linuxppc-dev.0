Return-Path: <xma@us.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 90D0E67A5D
	for <linuxppc-dev@ozlabs.org>; Wed, 10 May 2006 04:42:23 +1000 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e31.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k49IgLcq007774
	for <linuxppc-dev@ozlabs.org>; Tue, 9 May 2006 14:42:21 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k49IgLUi239648
	for <linuxppc-dev@ozlabs.org>; Tue, 9 May 2006 12:42:21 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id
	k49IgK73029698
	for <linuxppc-dev@ozlabs.org>; Tue, 9 May 2006 12:42:21 -0600
In-Reply-To: <adar733avvs.fsf@cisco.com>
To: Roland Dreier <rdreier@cisco.com>
MIME-Version: 1.0
Subject: Re: [openib-general] Re: [PATCH 07/16] ehca: interrupt handling
	routines
Message-ID: <OF426CC8FB.A39E8DCD-ON87257169.0066BA53-88257169.006BD807@us.ibm.com>
From: Shirley Ma <xma@us.ibm.com>
Date: Tue, 9 May 2006 11:44:49 -0700
Content-Type: multipart/alternative;
	boundary="=_alternative 006BD7FC88257169_="
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org,
	linuxppc-dev@ozlabs.org, Christoph Raisch <RAISCH@de.ibm.com>,
	Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>, Marcus Eder <MEDER@de.ibm.com>,
	openib-general-bounces@openib.org,
	"Michael S. Tsirkin" <mst@mellanox.co.il>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multipart message in MIME format.
--=_alternative 006BD7FC88257169_=
Content-Type: text/plain; charset="US-ASCII"

Roland Dreier <rdreier@cisco.com> wrote on 05/09/2006 11:36:07 AM:

> But there's no reason why the two threads can't be pinned to different
> CPUs or given exclusive CPU masks, exactly the same way that ehca
> implements it.
> 
>  - R.

I could try this. Let's see how much latency increase there.

Shirley Ma
IBM Linux Technology Center
15300 SW Koll Parkway
Beaverton, OR 97006-6063
Phone(Fax): (503) 578-7638
--=_alternative 006BD7FC88257169_=
Content-Type: text/html; charset="US-ASCII"


<br><font size=2><tt>Roland Dreier &lt;rdreier@cisco.com&gt; wrote on 05/09/2006
11:36:07 AM:<br>
<br>
&gt; But there's no reason why the two threads can't be pinned to different<br>
&gt; CPUs or given exclusive CPU masks, exactly the same way that ehca<br>
&gt; implements it.<br>
&gt; <br>
&gt; &nbsp;- R.<br>
</tt></font>
<br><font size=2><tt>I could try this. Let's see how much latency increase
there.</tt></font>
<br>
<br><font size=2 face="sans-serif">Shirley Ma<br>
IBM Linux Technology Center<br>
15300 SW Koll Parkway<br>
Beaverton, OR 97006-6063<br>
Phone(Fax): (503) 578-7638</font>
--=_alternative 006BD7FC88257169_=--
