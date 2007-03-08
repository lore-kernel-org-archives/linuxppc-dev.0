Return-Path: <linas@austin.ibm.com>
Date: Thu, 8 Mar 2007 17:50:45 -0600
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [patch 0/7] [RFC] Xenon support
Message-ID: <20070308235045.GG30703@austin.ibm.com>
References: <20070307180144.812594000@elitedvb.net>
	<20070308113545.5dcc2565.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070308113545.5dcc2565.sfr@canb.auug.org.au>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: Linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Mar 08, 2007 at 11:35:45AM +1100, Stephen Rothwell wrote:
> 
> Sorry, but given the anonymity requirement above, I do not want to even
> read these patches.  Tracking of the pedigree of code in Linux has become
> an issue and deevelopers want to be anonymous really pokes a big hole in
> that.

Please note that legal systems do have pretty robust notions about 
"reasonable people" and "reasonable behaviour".  Having gone through
the patches, I can affirm that these are utterly unremarkable, perfectly
ordinary patches, and there is no way that any "reasonable person" will 
get "contaminated" reading this stuff. The code looks like any other 
ethernet or ide or sata code; a few register definitions are different, 
but that's about it. 

Concepts like "pedigree" and "contamination" and "certificate of 
originality" and etc. apply when the code in question starts doing
things that are unique, novel, "not obvious to practitioners
versed in the state of the art".  When some code implements something
unusual, then there can be legitimate concerns about infringing on
some patent, etc.

At most, one might argue that there are some "trade secrets" in that
code. However, "trade secrets" are not protected by law: once they're
public, the're not secret any more, and the holder of the secret is
plain out-of-luck, and has no legal recourse. 

Oh, did I mention I'm not a lawyer, never studied law, etc. etc.?
The above is all my personal opinion, not that or my employer etc. 

--linas
