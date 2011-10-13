Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
 by ozlabs.org (Postfix) with SMTP id 91FE8B70C7
 for <linuxppc-dev@ozlabs.org>; Fri, 14 Oct 2011 02:45:11 +1100 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
 by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 22101-02 for <linuxppc-dev@ozlabs.org>;
 Thu, 13 Oct 2011 16:38:26 +0100 (BST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH][v2] uio: Support 36-bit physical addresses on 32-bit
 systems
Date: Thu, 13 Oct 2011 16:37:20 +0100
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6D8AE7E@saturn3.aculab.com>
In-Reply-To: <4E9704F9.1090103@freescale.com>
From: "David Laight" <David.Laight@ACULAB.COM>
To: "Timur Tabi" <timur@freescale.com>,
 "Kumar Gala" <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, hjk@hansjkoch.de,
 Jiang Kai-B18973 <B18973@freescale.com>, gregkh@suse.de,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

=20
> Kumar Gala wrote:
> >>> >> +       phys_addr_t             addr;
> >> >=20
> >> > Please add a comment here saying:
> >> >=20
> >> > 1) That 'addr' can be a virtual or physical address
> > The code and everything else makes that clear
>=20
> I'm sorry, but I have to strongly disagree here.  It is *NOT*=20
> clear that a variable of type 'phys_addr_t' can hold something
> that is not a physical address.

Since there is a discriminating field, could a union be used?
At a guess the type of the address is constrained between
produces and consumer??

	David
