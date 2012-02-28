Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
 by ozlabs.org (Postfix) with SMTP id AD8E5B6EEA
 for <linuxppc-dev@ozlabs.org>; Tue, 28 Feb 2012 21:04:50 +1100 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
 by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 10853-06 for <linuxppc-dev@ozlabs.org>;
 Tue, 28 Feb 2012 10:04:43 +0000 (GMT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 20/21] Introduce struct eeh_stats for EEH
Date: Tue, 28 Feb 2012 10:04:00 -0000
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6026B6E82@saturn3.aculab.com>
In-Reply-To: <1330409051-8941-21-git-send-email-shangw@linux.vnet.ibm.com>
From: "David Laight" <David.Laight@ACULAB.COM>
To: "Gavin Shan" <shangw@linux.vnet.ibm.com>,
	<linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

=20
> +struct eeh_stats {
> +	unsigned int no_device;		/* PCI device not found */
...
> +				"no device           =3D%d\n"
...

Use %u (for all the stats), you really don't want negative
values printed.
I've NFI how long wrapping these counters might take!
If it is feasable (maybe much above 100Hz) then you
need 64bit counters.

	David
