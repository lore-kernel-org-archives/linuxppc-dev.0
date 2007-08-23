Return-Path: <segher@kernel.crashing.org>
In-Reply-To: <20070823020147.GB7042@localhost.localdomain>
References: <20070820173920.GA30546@ld0162-tx32.am.freescale.net>
	<20070820173949.GD30562@ld0162-tx32.am.freescale.net>
	<20070821023044.GF15469@localhost.localdomain>
	<46CB0E56.2020601@freescale.com>
	<20070822010907.GA12472@localhost.localdomain>
	<20070822172456.GA22932@ld0162-tx32.am.freescale.net>
	<20070823020147.GB7042@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <7fe3a52180df5275c4428a04acbe3ea7@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 05/20] bootwrapper: flatdevtree fixes
Date: Thu, 23 Aug 2007 20:00:26 +0200
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Actually, in any case, I don't think we want to implement get_path()
> this way for real OF.  Better to have get_path() itself as a callback:
> on real OF I believe we can directly ask for the full path to a given
> phandle,

Yes.  "package-to-path" from the client interface.


Segher
