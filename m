Return-Path: <michael@ellerman.id.au>
Message-ID: <1343193511.2218.10.camel@concordia>
Subject: Re: [2/3][PATCH][upstream] TDM Framework
From: Michael Ellerman <michael@ellerman.id.au>
To: Tabi Timur-B04825 <B04825@freescale.com>
Date: Wed, 25 Jul 2012 15:18:31 +1000
In-Reply-To: <500F5C99.6060704@freescale.com>
References: <1343040588-16002-1-git-send-email-b37400@freescale.com>
 <CAOZdJXVnEUEQesyG52pL_jerGDrmJLxdfBNFrj_xvhPs=ue4DA@mail.gmail.com>
 <3F1D9DCAAB49B94D88DBE05911FA4E6E50ED27@039-SN1MPN1-006.039d.mgd.msft.net>
 <500EB47F.1040903@freescale.com> <1343173422.2218.2.camel@concordia>
 <500F5C99.6060704@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Aggrwal Poonam-B10812 <B10812@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Singh Sandeep-B37400 <B37400@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2012-07-25 at 02:40 +0000, Tabi Timur-B04825 wrote:
> Michael Ellerman wrote:
> > I agree these values are odd. But there's no rule that you can only use
> > an enum if the values are monotonically increasing.
> >
> > It can still serve as helpful documentation, and reduce the number of
> > places you pass a bare int around.
> 
> IMHO, an enum should only be used if
> 
> 1) You are doing real type checking of the enum

Yes, if you're going to define an enum you should use it, which this
patch doesn't, but that's just a bug in this patch.

> 2) You don't care what the actual values of each enum is

I disagree.

They make even more sense when you don't care what the values are, but
that doesn't mean you should only use them in those cases.

And the bible, K & R, includes an example of an enum which explicitly
specifies all its values. It goes on to say "enumeration variables offer
the chance of [type] checking and so are often better than #defines".

cheers
