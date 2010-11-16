Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
	by ozlabs.org (Postfix) with SMTP id 237BBB7137
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 17 Nov 2010 02:36:27 +1100 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
	by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new,
	port 10024) with SMTP
	id 06338-01 for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 16 Nov 2010 15:36:07 +0000 (GMT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Corrected data type mismatch
Date: Tue, 16 Nov 2010 15:35:13 -0000
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6D8ABAE@saturn3.aculab.com>
In-Reply-To: <029A97EE-F051-4E8A-93E9-C259D2A7622E@gmail.com>
From: "David Laight" <David.Laight@ACULAB.COM>
Cc: <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

=20
> > OOPS! It is wrong here, The right one should be as following:
> >=20
> > -   memcpy(mem, current->thread.evr[regno-32],
> > +   memcpy(mem, (void*)&current->thread.evr[regno-32],
dbg_reg_def[regno].size);

The (void *) cast should be unnecessary ....

	David
