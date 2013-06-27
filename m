Return-Path: <michael@ellerman.id.au>
Message-ID: <1372333965.29229.26.camel@concordia>
Subject: Re: [PATCH 8/8] powerpc/perf: Add power8 EBB support
From: Michael Ellerman <michael@ellerman.id.au>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Date: Thu, 27 Jun 2013 21:52:45 +1000
In-Reply-To: <51CABB56.9010105@linux.vnet.ibm.com>
References: <1372073336-8189-1-git-send-email-michael@ellerman.id.au>
 <1372073336-8189-8-git-send-email-michael@ellerman.id.au>
 <51CABB56.9010105@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, sukadev@linux.vnet.ibm.com,
 Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Wed, 2013-06-26 at 15:28 +0530, Anshuman Khandual wrote:
> > @@ -117,6 +117,7 @@
> >  	 (EVENT_UNIT_MASK      << EVENT_UNIT_SHIFT)		|	\
> >  	 (EVENT_COMBINE_MASK   << EVENT_COMBINE_SHIFT)		|	\
> >  	 (EVENT_MARKED_MASK    << EVENT_MARKED_SHIFT)		|	\
> > +	 (1ull		       << EVENT_CONFIG_EBB_SHIFT)	|	\
> 
> We should define this macro like EVENT_MARKED_MASK
> 
> #define EVENT_EBB_MASK       0x1
> 
> Numeric value of "1ull" stands out odd in the scheme.

Yeah I guess.

Would you like it in blue? :)

cheers
