Return-Path: <michael@ellerman.id.au>
Message-ID: <1355193671.8733.6.camel@concordia>
Subject: Re: [PATCH 5/6] powerpc: Macros for saving/restore PPR
From: Michael Ellerman <michael@ellerman.id.au>
To: Haren Myneni <haren@linux.vnet.ibm.com>
Date: Tue, 11 Dec 2012 13:41:11 +1100
In-Reply-To: <50B41C27.4020905@linux.vnet.ibm.com>
References: <1351666574.32304.18.camel@hbabu-laptop>
 <27433.1353641997@neuling.org> <50B41C27.4020905@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: paulus@samba.org, anton@au1.ibm.com,
 Michael Neuling <michael.neuling@au1.ibm.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2012-11-26 at 17:49 -0800, Haren Myneni wrote:
> On 11/22/2012 07:39 PM, Michael Neuling wrote:
> > Haren Myneni <haren@linux.vnet.ibm.com> wrote:
> > 
> >> [PATCH 5/6] powerpc: Macros for saving/restore PPR
> > 
> > Maybe we should change the names 
> >   HTM_MEDIUM_NO_PPR  => HTM_MEDIUM_PPR_DISCARD   and
> >   HTM_MEDIUM_HAS_PPR => HTM_MEDIUM_PPR_SAVE
> > But now I'm heading into bike shedding territory... plus I think I
> > suggested the names you have currently, so I'm feeling a bit dumb now
> > :-)
> 
> No problem, We can change these macro names if HTM_MEDIUM_PPR_DISCARD/
> HTM_MEDIUM_PPR_SAVE gives better description.

Yes, those names are better.

Even though they're macros they act as functions, so they should
preferably be named using a verb.

cheers
