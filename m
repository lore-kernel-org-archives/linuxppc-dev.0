Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18372.48069.303412.110906@cargo.ozlabs.ibm.com>
Date: Wed, 27 Feb 2008 12:24:21 +1100
From: Paul Mackerras <paulus@samba.org>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Patches added to master & powerpc-next branches of powerpc.git
In-Reply-To: <12F84CB4-8344-4F70-A89F-4A1FF590C35C@kernel.crashing.org>
References: <18371.65529.312001.673609@cargo.ozlabs.ibm.com>
	<12F84CB4-8344-4F70-A89F-4A1FF590C35C@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala writes:

> How do you plan on managing the powerpc-next branch in the future?   
> For example, I assume at some point linus will pull it into what would  
> be 2.6.26.  Would you rebase this branch?  etc.

Yes, it is basically the for-2.6.26 branch.  I will try very hard not
to rebase it, but I don't promise that I will never rebase it.

I'm expecting to get requests to pull your tree into it, as well as
Josh's, Grant's, etc., once you have stuff that you are reasonably
confident should go in to the next release and won't need to be
rebased.

Paul.
