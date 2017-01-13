Return-Path: <David.Laight@ACULAB.COM>
Received: from smtp-out4.electric.net (smtp-out4.electric.net
 [192.162.216.181])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v0TpS35SdzDqqL
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Jan 2017 04:17:36 +1100 (AEDT)
From: David Laight <David.Laight@ACULAB.COM>
To: "'Naveen N. Rao'" <naveen.n.rao@linux.vnet.ibm.com>, "mpe@ellerman.id.au"
 <mpe@ellerman.id.au>
CC: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "ast@fb.com" <ast@fb.com>,
 "daniel@iogearbox.net" <daniel@iogearbox.net>, "davem@davemloft.net"
 <davem@davemloft.net>
Subject: RE: [PATCH 3/3] powerpc: bpf: implement in-register swap for 64-bit
 endian operations
Date: Fri, 13 Jan 2017 17:17:26 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DB02635FB@AcuExch.aculab.com>
References: <e73efe6facf6c06932b4a87707e5978172ee773e.1484326337.git.naveen.n.rao@linux.vnet.ibm.com>
 <bb264395301754f43b77ddec68a16dd34220abb4.1484326337.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <bb264395301754f43b77ddec68a16dd34220abb4.1484326337.git.naveen.n.rao@linux.vnet.ibm.com>
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

From: Naveen N. Rao
> Sent: 13 January 2017 17:10
> Generate instructions to perform the endian conversion using registers,
> rather than generating two memory accesses.
>=20
> The "way easier and faster" comment was obviously for the author, not
> the processor.

That rather depends on whether the processor has a store to load forwarder
that will satisfy the read from the store buffer.
I don't know about ppc, but at least some x86 will do that.

	David
