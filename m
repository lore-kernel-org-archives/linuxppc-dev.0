Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18179.2249.445607.10676@cargo.ozlabs.ibm.com>
Date: Wed, 3 Oct 2007 13:13:13 +1000
From: Paul Mackerras <paulus@samba.org>
To: will_schmidt@vnet.ibm.com
Subject: Re: [PATCH] Use 1TB segments
In-Reply-To: <1191350274.18159.279.camel@farscape.rchland.ibm.com>
References: <18095.59959.698141.565343@cargo.ozlabs.ibm.com>
	<1191350274.18159.279.camel@farscape.rchland.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Jon Tollefson <kniht@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Will Schmidt writes:

> I still need to test this code for performance issues, and this version
> could still use some cosmetic touchups, so I dont think we want this to
> go into a tree yet.  I am reposting this primarily to indicate the prior
> version isnt quite right, and so Jon can rebase to this version.  :-)

The way we scan the ibm,processor-segment-sizes property could be
nicer.  Where there any other cosmetic touchups you were thinking of,
and if so what were they?  I didn't notice any leftover debugging
printks or anything else that obviously needed cleaning up.

Paul.
