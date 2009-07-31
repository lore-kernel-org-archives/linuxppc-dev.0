Return-Path: <mlei@Brocade.COM>
Received: from hq-exedge.brocade.com (hq-exedge.brocade.com [66.243.153.83])
	by bilbo.ozlabs.org (Postfix) with ESMTP id D8492B7B7D
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  1 Aug 2009 06:42:35 +1000 (EST)
From: Ming Lei <mlei@Brocade.COM>
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Date: Fri, 31 Jul 2009 13:36:45 -0700
Subject: question on PPC64 relocatable kernel
Message-ID: <7301F255FCB62048851F165FFAAF9BD102516DDA43@HQ-EXCH-7.corp.brocade.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

I am researching PPC64 code and try to come up a design for relocatable ker=
nel for ppc32. I noticed that the current ppc64 implementation only changes=
 all the entries in RELA table to add the offset from compile load address =
to relocated address, but not for GOT table. Does GOT entry need the adjust=
ment as well?

The second question is: does PPC64 relocatable kernel still needs to copy t=
he whole kernel from running address to address 0?

Thanks
Ming
