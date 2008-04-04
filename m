Return-Path: <hollisb@us.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 55029DE012
	for <linuxppc-dev@ozlabs.org>; Sat,  5 Apr 2008 01:33:23 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m34EVUxk002227
	for <linuxppc-dev@ozlabs.org>; Fri, 4 Apr 2008 10:31:30 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m34EXFvZ187186
	for <linuxppc-dev@ozlabs.org>; Fri, 4 Apr 2008 08:33:15 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m34EXEnI020668
	for <linuxppc-dev@ozlabs.org>; Fri, 4 Apr 2008 08:33:15 -0600
From: Hollis Blanchard <hollisb@us.ibm.com>
To: jyoung5@us.ibm.com
Subject: Re: [kvm-ppc-devel] [PATCH] Add idle wait support for 44x platforms
Date: Fri, 4 Apr 2008 09:33:13 -0500
References: <7226bef216680748a503.1207262582@thinkpadL>
	<20080403210027.05339204@zod.rchland.ibm.com>
	<1207288799.6971.11.camel@thinkpadL>
In-Reply-To: <1207288799.6971.11.camel@thinkpadL>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200804040933.13936.hollisb@us.ibm.com>
Cc: kvm-ppc-devel@lists.sourceforge.net, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 04 April 2008 00:59:59 Jerone Young wrote:
> On Thu, 2008-04-03 at 21:00 -0500, Josh Boyer wrote:
> > On Thu, 03 Apr 2008 17:43:02 -0500
> >
> > Jerone Young <jyoung5@us.ibm.com> wrote:
> > > # HG changeset patch
> > > # User Jerone Young <jyoung5@us.ibm.com>
> > > # Date 1207262487 18000
> > > # Node ID 7226bef216680748a50327900572c2fbc3e762b0
> > > # Parent =A0a5b2aebbc6ebd2439c655f1c047ed7e3c1991ec1
> >
> > As a complete and unrelated side note to the actual patch, wtf is this
> > hg stuff? =A0I can't really tell what tree you're even basing this off =
of.
>
> hehe...I primary use hg as it's just much easier to deal with. Yes I do
> go through the conversion. But it is worth it. The patches I send are in
> git format.

By the way, you can use "hg email --plain" to avoid confusing the=20
unenlightened. ;) The Mercurial changeset data won't be useful here=20
anyways...

In reply to an earlier unrelated comment, there is also "hg email --diffsta=
t".

=2D-=20
Hollis Blanchard
IBM Linux Technology Center
