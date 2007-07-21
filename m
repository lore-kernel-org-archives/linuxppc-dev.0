Return-Path: <viro@ftp.linux.org.uk>
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [195.92.253.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 88E02DDE06
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 22 Jul 2007 02:47:43 +1000 (EST)
Date: Sat, 21 Jul 2007 17:46:21 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Chris Snook <csnook@redhat.com>
Subject: Re: [PATCH][12/37] Clean up duplicate includes in drivers/net/
Message-ID: <20070721164621.GN21668@ftp.linux.org.uk>
References: <200707211702.46375.jesper.juhl@gmail.com>
	<46A236FC.2080300@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <46A236FC.2080300@redhat.com>
Cc: info@netxen.com, Patrick McHardy <kaber@coreworks.de>,
	Judy Fischbach <jfisch@cs.pdx.edu>, Luke Yang <luke.yang@analog.com>,
	bonding-devel@lists.sourceforge.net,
	Bryan Wu <bryan.wu@analog.com>, kong.lai@tundra.com,
	Jay Vosburgh <fubar@us.ibm.com>,
	James Morris <jmorris@namei.org>, linuxppc-embedded@ozlabs.org,
	Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
	Alex V Lasso <a_villacis@palosanto.com>,
	Ulrich Kunitz <kune@deine-taler.de>,
	Chad Tindel <ctindel@users.sourceforge.net>,
	Amit S Kale <amitkale@netxen.com>, Jay Cliburn <jcliburn@gmail.com>,
	Samuel Ortiz <samuel@sortiz.org>, Brian Pugh <bpugh@cs.pdx.edu>,
	Daniel Drake <dsd@gentoo.org>, alexandre.bounine@tundra.com,
	Pantelis Antoniou <panto@intracom.gr>, netdev@vger.kernel.org,
	Jesper Juhl <jesper.juhl@gmail.com>, linux-wireless@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Ralf Baechle <ralf@linux-mips.org>, Vitaly Bordug <vbordug@ru.mvista.com>,
	Lukasz Stelmach <stlman@poczta.fm>, Ron Mercer <linux-driver@qlogic.com>,
	atl1-devel@lists.sourceforge.net,
	Andrew Morton <akpm@linux-foundation.org>,
	"David S. Miller" <davem@davemloft.net>,
	James P Ketrenos <ipw2100-admin@linux.intel.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Sat, Jul 21, 2007 at 12:40:28PM -0400, Chris Snook wrote:
> Define "duplicate".  I ask because this patch just got posted a few days 
> ago:

... and it had been wrong - it's really a duplicate (check several lines
above).  My apologies.
