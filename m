Return-Path: <andi@firstfloor.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 531F4B7BAA
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  1 Aug 2009 02:53:01 +1000 (EST)
Received: from one.firstfloor.org (one.firstfloor.org [213.235.205.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DAC5EDDDA0
	for <linuxppc-dev@ozlabs.org>; Sat,  1 Aug 2009 02:53:00 +1000 (EST)
To: Mike Mason <mmlnx@us.ibm.com>
Subject: Re: [PATCH 1/3] Support for PCI Express reset type
From: Andi Kleen <andi@firstfloor.org>
References: <4A721FB1.4040903@us.ibm.com>
Date: Fri, 31 Jul 2009 18:19:30 +0200
In-Reply-To: <4A721FB1.4040903@us.ibm.com> (Mike Mason's message of "Thu,
	30 Jul 2009 15:33:21 -0700")
Message-ID: <87hbws3jvx.fsf@basil.nowhere.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Richard Lary <rlary@us.ibm.com>, linux-pci@vger.kernel.org,
	linasvepstas@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Mike Mason <mmlnx@us.ibm.com> writes:
>
> These patches supersede the previously submitted patch that
> implemented a fundamental reset bit field. 
>
> Please review and let me know of any concerns.

Any plans to implement that for x86 too? Right now it seems to be a PPC
specific hack. And where is the driver that is using it?

-Andi

-- 
ak@linux.intel.com -- Speaking for myself only.
