Date: Thu, 5 Feb 2004 19:11:01 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: Stephen Williams <612dlag102@sneakemail.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Which kernel tree
Message-ID: <20040206031101.GB6578@gate.ebshome.net>
References: <10045-28297@sneakemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <10045-28297@sneakemail.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Feb 05, 2004 at 07:01:08PM -0800, Stephen Williams wrote:
>
> I've got u-boot working on my custom board, so now it's getting
> time to build a working kernel for my system-to-be.
>
> I have a PPC405GPr. I'll be writing drivers for the SystemACE
> and custom chips on the board, but I might as well do that work
> on a kernel that I'll be able to use for a while. So that begs
> the question, which kernel tree should I be following?
>
> There's the one at denx, that seems to be 2.4.4 from over
> a year ago, or there are the kernels at www.kernel.org,
> that may not have the up to date parts, or there's the
> bkbits.net bitkeeper tree.
>

Try linuxppc-2.4 BK tree (ppc.bkbits.net) it should work just fine for
405GPr.

If you have problems with 405 and this tree, please post them to this
list :).

Eugene.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
