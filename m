Return-Path: <michael@ellerman.id.au>
Date: Tue, 23 Jul 2013 23:42:19 +1000
From: Michael Ellerman <michael@ellerman.id.au>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH] Fix a typo in pSeries_lpar_hpte_insert()
Message-ID: <20130723134219.GE31944@concordia>
References: <1374470630-2106-1-git-send-email-kda@linux-powerpc.org>
 <874nbmobww.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <874nbmobww.fsf@linux.vnet.ibm.com>
Cc: Denis Kirjanov <kda@linux-powerpc.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jul 22, 2013 at 08:54:31PM +0530, Aneesh Kumar K.V wrote:
> Denis Kirjanov <kda@linux-powerpc.org> writes:
> 
> > Fix a typo in pSeries_lpar_hpte_insert()
> >
> > Signed-off-by: Denis Kirjanov <kda@linux-powerpc.org>
> 
> looks good
> 
> Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> 
> We may want to add the commit that introduced the change ?
> 
> 801eb73f45371accc78ca9d6d22d647eeb722c11

Yes, as well as describe what the typo is, and what the implications
are - ie. what was broken and is now fixed.

cheers
