Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
	by ozlabs.org (Postfix) with SMTP id 03362B7199
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 18 Nov 2010 23:53:40 +1100 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
	by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new,
	port 10024) with SMTP
	id 03166-08 for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 18 Nov 2010 12:53:29 +0000 (GMT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: application needs fast access to physical memory
Date: Thu, 18 Nov 2010 12:52:33 -0000
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6D8ABB6@saturn3.aculab.com>
In-Reply-To: <1290083062.22575.9.camel@concordia>
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
> On Wed, 2010-11-17 at 16:03 -0600, steven.lin@teradyne.com wrote:
> > My application needs a fast way to access a specific physical DDR
> > memory region. The application runs on an MPC8548 PowerPC which has
an
> > MMU. I've tried two approaches that are typical for Linux, mmap()
and
> > using a kernel module that implements read()/write() into this
region
> > and I'm finding that performance is very slow for both. It's a
couple
> > orders of magnitude slower than, for example, copying a large buffer
> > from one place in the application's virtual memory to another place
in
> > the application's virtual memory.
>=20
> The mmap() version should basically run at "full speed", at least once
> you've faulted the address range in.
>=20
> This specific DDR region isn't specifically slow is it ? :)

Or being mapped uncached ?

	David
