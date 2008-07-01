Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18537.34789.355993.604857@cargo.ozlabs.ibm.com>
Date: Tue, 1 Jul 2008 11:27:01 +1000
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: Re: Commits added to powerpc.git master and powerpc-next branches
In-Reply-To: <18537.30774.608486.268257@cargo.ozlabs.ibm.com>
References: <18537.30774.608486.268257@cargo.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul Mackerras writes:

> The following commits have been added to the master and powerpc-next
> branches of the powerpc.git repository.  This includes patches pulled
> from Kumar's and Josh's trees.

Hold off from pulling this for now, everyone...  I inadvertently broke
builds with 64k pages by leaving in some stuff that was purely for
testing in my "Only demote individual slices rather than whole
process" patch.  I'll re-do the tree in order to avoid breaking
bisection.

Paul.
