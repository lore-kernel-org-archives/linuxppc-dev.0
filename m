Return-Path: <mpe@ellerman.id.au>
Message-ID: <1391228882.15250.2.camel@concordia>
Subject: Re: [PATCH] powerpc: Add cpu family documentation
From: Michael Ellerman <mpe@ellerman.id.au>
To: Kumar Gala <galak@kernel.crashing.org>
Date: Sat, 01 Feb 2014 15:28:02 +1100
In-Reply-To: <669D726F-25DF-4703-AD30-CAE7CA142970@kernel.crashing.org>
References: <1391049480-29346-1-git-send-email-mpe@ellerman.id.au>
 <669D726F-25DF-4703-AD30-CAE7CA142970@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2014-01-31 at 07:32 -0600, Kumar Gala wrote:
> On Jan 29, 2014, at 8:38 PM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> > +Freescale BookE
> > +---------------
> > +
> > + - Software loaded TLB.
> > + - e6500 adds HW loaded indirect TLB entries.
> > + - Mix of 32 & 64 bit
> > +
> > +  e200 --- e500 --- e500v2 --- e500mc --- e5500 --- e6500
> > +                                         (Book3E)  (HW TLB)
> > +                                         (64bit)
> > +
> 
> e200 is its own core family that doesn’t have any relation to e500 line other than being book-e
> 
> might want to add multithreaded to e6500.

Thanks Kumar.

cheers
