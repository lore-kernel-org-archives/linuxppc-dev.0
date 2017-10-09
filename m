Return-Path: <David.Laight@ACULAB.COM>
Received: from smtp-out6.electric.net (smtp-out6.electric.net
 [192.162.217.184])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y9kYJ5ksFzDqlv
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Oct 2017 02:24:03 +1100 (AEDT)
From: David Laight <David.Laight@ACULAB.COM>
To: "'naveen.n.rao@linux.vnet.ibm.com'" <naveen.n.rao@linux.vnet.ibm.com>
CC: 'Sandipan Das' <sandipan@linux.vnet.ibm.com>, "paulus@samba.org"
 <paulus@samba.org>, "anton@samba.org" <anton@samba.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: RE: [PATCH] powerpc/lib/sstep: Fix count leading zeros instructions
Date: Mon, 9 Oct 2017 15:24:00 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DD008DA6B@AcuExch.aculab.com>
References: <20171009110726.28551-1-sandipan@linux.vnet.ibm.com>
 <063D6719AE5E284EB5DD2968C1650D6DD008D92D@AcuExch.aculab.com>
 <20171009142053.GA4406@gate.crashing.org>
 <063D6719AE5E284EB5DD2968C1650D6DD008D9DE@AcuExch.aculab.com>
 <20171009144751.wkox4viisyycv2oj@naverao1-tp.localdomain>
In-Reply-To: <20171009144751.wkox4viisyycv2oj@naverao1-tp.localdomain>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: naveen.n.rao@linux.vnet.ibm.com
> Sent: 09 October 2017 15:48
...
> This is about the behavior of the gcc builtin being undefined, rather
> than the actual cpu instruction itself.

I'd have hoped that the ggc builtin just generated the expected cpu instruc=
tion.
So is only undefined because it is very cpu dependant.

More problematic here would be any cpu flag register settings.
eg: x86 would set the 'Z' flag for zero input.

	David
