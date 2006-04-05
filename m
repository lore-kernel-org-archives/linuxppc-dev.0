Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17460.17562.163079.347023@cargo.ozlabs.ibm.com>
Date: Thu, 6 Apr 2006 08:28:42 +1000
From: Paul Mackerras <paulus@samba.org>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 00/15] powerpc: move some header files
In-Reply-To: <C1CE62AD-7989-4DCA-B7B3-8A107ACBD153@kernel.crashing.org>
References: <11442138494042-git-send-email-sfr@canb.auug.org.au>
	<C40B1083-7953-4104-8FA3-5B9B4EBE1A77@kernel.crashing.org>
	<20060406020313.186a74ad.sfr@canb.auug.org.au>
	<C1CE62AD-7989-4DCA-B7B3-8A107ACBD153@kernel.crashing.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala writes:

> > I guess that would work, but Paulus is going to not like me as he  
> > already
> > put all these patches into the powerpc tree.  :-)
> 
> That's Paulus own doing for his premature pull :)

For now I have reverted the powerpc.git tree to remove those commits
of Stephen's, so all it has now (compared to v2.6.17-rc1) are a CHRP
booting fix and the "iSeries has only 256 IRQs" patch.

Everyone, if you have done a pull from powerpc.git in the last 24
hours, please do this on your repository:

git reset b86756ae76dc5e7ecff3ca52a5842155e6d457de

That will get us back into sync.  Sorry about the to-ing and fro-ing
on this.

Paul.
