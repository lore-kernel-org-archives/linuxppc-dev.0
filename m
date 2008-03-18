Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id AAC15DDFE9
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Mar 2008 11:27:22 +1100 (EST)
Date: Mon, 17 Mar 2008 19:34:34 -0500
From: Olof Johansson <olof@lixom.net>
To: Tony Breeds <tony@bakeyournoodle.com>
Subject: Re: [PATCH v2] Force 4K pages for IO addresses.
Message-ID: <20080318003434.GA671@lixom.net>
References: <20080317034758.GG6887@bakeyournoodle.com>
	<20080317035419.GH6887@bakeyournoodle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080317035419.GH6887@bakeyournoodle.com>
Cc: LinuxPPC-dev <linuxppc-dev@ozlabs.org>,
	Jan-Bernd Themann <themann@de.ibm.com>, Paul Mackerras <paulus@samba.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Mar 17, 2008 at 02:54:19PM +1100, Tony Breeds wrote:
> Currently HEA requires 4K pages for IO resources.  Just set the pages size to
> IO to 4K.

Well, that's too bad. Why penalize all platforms for it?

I.e.: Nack, we use 64K iopages on pa6t and it works well. No need to
waste tlb and erat space.


-Olof
