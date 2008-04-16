Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18437.62522.276473.12143@cargo.ozlabs.ibm.com>
Date: Wed, 16 Apr 2008 22:42:34 +1000
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: Re: More patches pushed to powerpc.git master and powerpc-next
	branches
In-Reply-To: <18437.61934.495516.351438@cargo.ozlabs.ibm.com>
References: <18437.61934.495516.351438@cargo.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I wrote:

> The following commits are now in the master and powerpc-next branches
> in the powerpc.git tree.  This includes commits pulled from Josh
> Boyer's and Olof Johansson's trees.

Because of a problem caused by a couple of commits in Josh Boyer's
tree, I have forced the master and powerpc-next branches back to where
they were until an hour or so ago.  Hopefully no-one has done a pull
in that time; if anyone has then they will need to do a git pull -f
when I eventually push the commits out (since they will have different
IDs).

Paul.
