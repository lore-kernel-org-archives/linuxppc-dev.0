Return-Path: <mpe@ellerman.id.au>
Message-ID: <1386900217.21216.8.camel@concordia>
Subject: Re: [PATCH] powerpc: set default kernel thread priority to medium-low
From: Michael Ellerman <mpe@ellerman.id.au>
To: Philippe Bergheaud <felix@linux.vnet.ibm.com>
Date: Fri, 13 Dec 2013 13:03:37 +1100
In-Reply-To: <52A961A0.5010307@linux.vnet.ibm.com>
References: <1386661163-4478-1-git-send-email-felix@linux.vnet.ibm.com>
 <1386743357.27999.1.camel@concordia> <1386755340.15730.11.camel@pasglop>
 <52A83EBE.4060305@linux.vnet.ibm.com> <1386811338.12662.3.camel@concordia>
 <52A961A0.5010307@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2013-12-12 at 08:11 +0100, Philippe Bergheaud wrote:
> Michael Ellerman wrote:
> > On Wed, 2013-12-11 at 11:30 +0100, Philippe Bergheaud wrote:
> > 
> >>Shouldn't we define a new macro HMT_DEFAULT, to identify explicitely where
> >>the default priority is required?
> > 
> > 
> > That might help clarify things yes.
>
> Thank you for the help. I will rework this.

Thanks.
