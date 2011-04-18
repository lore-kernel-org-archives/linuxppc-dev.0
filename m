Return-Path: <benh@kernel.crashing.org>
Subject: Re: [PATCH 14/15] powerpc: Add WSP platform
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <A6E5DD55-F9D1-430E-BAA7-E770523821A0@kernel.crashing.org>
References: <d284a5076d7760656470a5fd16d98ec6501a9bf3.1302856271.git.michael@ellerman.id.au>
	<02b9880aa9ef5d49b473c894bce886f2060f9f0b.1302856271.git.michael@ellerman.id.au>
	<A6E5DD55-F9D1-430E-BAA7-E770523821A0@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 19 Apr 2011 07:39:49 +1000
Message-ID: <1303162789.28876.162.camel@pasglop>
Mime-Version: 1.0
Cc: Michael Ellerman <michael@ozlabs.org>, Jimi Xenidis <jimix@watson.ibm.com>,
	jack@codezen.org, imunsie@au.ibm.com, linuxppc-dev@ozlabs.org,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2011-04-18 at 07:46 -0500, Kumar Gala wrote:
> 
> Can this be moved into kernel/cpu_setup_a2.S.  This and the debug
> patch that follows are bit ugly.

Well, the code per-se is not really A2 specific... the labels and
comments are :-)

Cheers,
Ben.
