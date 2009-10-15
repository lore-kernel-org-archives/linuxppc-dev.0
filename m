Return-Path: <JBeulich@novell.com>
Received: from vpn.id2.novell.com (vpn.id2.novell.com [195.33.99.129])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "emea1-mh.id2.novell.com", Issuer "APPS" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id D553CB7B7C
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 15 Oct 2009 18:26:58 +1100 (EST)
Message-Id: <4AD6EB17020000780001A050@vpn.id2.novell.com>
Date: Thu, 15 Oct 2009 08:27:51 +0100
From: "Jan Beulich" <JBeulich@novell.com>
To: "Hollis Blanchard" <hollisb@us.ibm.com>
Subject: Re: linux-next: tree build failure
References: <4AC1E15502000078000516B5@vpn.id2.novell.com>
	<1254267572.15622.1621.camel@slab.beaverton.ibm.com>
	<4AC318450200007800017355@vpn.id2.novell.com>
	<1254498517.3839.17.camel@slab.beaverton.ibm.com>
	<4AC9B5310200007800017EA1@vpn.id2.novell.com>
	<1255115648.2546.71.camel@slab.beaverton.ibm.com>
	<1255561026.29192.0.camel@slab.beaverton.ibm.com>
In-Reply-To: <1255561026.29192.0.camel@slab.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: sfr@canb.auug.org.au, Rusty Russell <rusty@rustcorp.com.au>,
	linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org,
	linux-next@vger.kernel.org, akpm@linux-foundation.org,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>>> Hollis Blanchard <hollisb@us.ibm.com> 15.10.09 00:57 >>>
>On Fri, 2009-10-09 at 12:14 -0700, Hollis Blanchard wrote:
>> Rusty's version of BUILD_BUG_ON() does indeed fix the build break, and
>> also exposes the bug in kvmppc_account_exit_stat(). So to recap:
>>=20
>> original: built but didn't work
>> Jan's: doesn't build
>> Rusty's: builds and works
>>=20
>> Where do you want to go from here?
>
>Jan, what are your thoughts? Your BUILD_BUG_ON patch has broken the
>build, and we still need to fix it.

My perspective is that it just uncovered already existing brokenness. And
honestly, I won't be able to get to look into this within the next days. =
(And
btw., when I run into issues with other people's code changes, quite
frequently I'm told to propose a patch, so I'm also having some
philosophical problem understanding why I can't simply expect the same
when people run into issues with changes I made, especially in cases like
this where it wasn't me introducing the broken code.) So, if this can wait
for a couple of days, I can try to find time to look into this. Otherwise, =
I'd
rely on someone running into the actual issue to implement a solution.

Jan
