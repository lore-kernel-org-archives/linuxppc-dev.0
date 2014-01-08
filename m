Return-Path: <anton@samba.org>
Date: Thu, 9 Jan 2014 01:14:29 +1100
From: Anton Blanchard <anton@samba.org>
To: David Laight <David.Laight@ACULAB.COM>
Subject: Re: [PATCH] slub: Don't throw away partial remote slabs if there is
 no local memory
Message-ID: <20140109011429.61ce8545@kryten>
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6D453A4E@AcuExch.aculab.com>
References: <20140107132100.5b5ad198@kryten>
 <063D6719AE5E284EB5DD2968C1650D6D453A4E@AcuExch.aculab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: "cl@linux-foundation.org" <cl@linux-foundation.org>,
 "nacc@linux.vnet.ibm.com" <nacc@linux.vnet.ibm.com>,
 "penberg@kernel.org" <penberg@kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "paulus@samba.org" <paulus@samba.org>, "mpm@selenic.com" <mpm@selenic.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi David,

> Why not just delete the entire test?
> Presumably some time a little earlier no local memory was available.
> Even if there is some available now, it is very likely that some won't
> be available again in the near future.

I agree, the current behaviour seems strange but it has been around
since the inital slub commit.

Anton
