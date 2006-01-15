Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17353.59069.640198.595911@cargo.ozlabs.ibm.com>
Date: Sun, 15 Jan 2006 17:07:57 +1100
From: Paul Mackerras <paulus@samba.org>
To: will schmidt <will_schmidt@vnet.ibm.com>
Subject: Re: powerpc.git tree
In-Reply-To: <43C55852.2060703@vnet.ibm.com>
References: <17348.60119.801379.127209@cargo.ozlabs.ibm.com>
	<43C55852.2060703@vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, linuxppc64-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

will schmidt writes:

> Paul Mackerras wrote:
> > 
> > That means that anyone who is following the powerpc.git tree by doing
> > pulls periodically will need to reset their tree too.  Otherwise each
> > pull will do an unnecessary merge.
> 
> Hi Paul,
> 
>    By reset, do you mean to delete the local tree and pull a fresh
>    one, or something fancier? 

The powerpc.git tree is now identical to Linus' tree as of a day or so
ago.  There are several ways you can reset your tree:

- make a fresh clone of Linus' tree, and make its .git/remotes/powerpc
  point at the powerpc.git tree on kernel.org, or

- do "git fetch -f powerpc" (substitute whatever remote name you use
  for the powerpc.git tree) (according to Stephen Rothwell), or

- do a pull as you would normally do, then throw away the merge and
  the extra objects by doing:
	git reset --hard FETCH_HEAD
	git prune

- or you can delete the local tree and do a fresh clone.

I will start putting stuff in powerpc.git in the next day or so.

Paul.
