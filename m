Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18190.42074.495464.74585@cargo.ozlabs.ibm.com>
Date: Fri, 12 Oct 2007 08:31:54 +1000
From: Paul Mackerras <paulus@samba.org>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: powerpc commits for 2.6.24
In-Reply-To: <3A203D25-2CC1-4450-ADA1-752A99504108@kernel.crashing.org>
References: <18190.5965.836544.396721@cargo.ozlabs.ibm.com>
	<3A203D25-2CC1-4450-ADA1-752A99504108@kernel.crashing.org>
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

> I'm debugging one issue with MPC8560 that should get fixed today with  
> a new pull request after I find the issue.

There's no particular hurry for bug fixes.

> Just to clarify, are we closing 2.6.24 for new code after you send  
> Linus a pull request or are we still taking things during the two  
> week merge window?

Basically, yes.  We got a lecture at kernel summit from Linus and
Andrew where we got told to get everything merged early in the merge
window.  I might make an exception for stuff that has already been
posted for review but still needs some minor changes, but other than
that, the window for new code has closed.

Paul.
