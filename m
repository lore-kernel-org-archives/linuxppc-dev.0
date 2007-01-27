Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17851.56598.494784.434589@cargo.ozlabs.ibm.com>
Date: Sun, 28 Jan 2007 10:15:34 +1100
From: Paul Mackerras <paulus@samba.org>
To: torvalds@osdl.org
Subject: Re: Please pull powerpc.git 'merge' branch
In-Reply-To: <17851.56154.749593.70103@cargo.ozlabs.ibm.com>
References: <17851.56154.749593.70103@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Linus,

I meant to add, in the pull request I just sent, that we are looking
into the known unfixed regression listed by Adrian Bunk with the
subject "powerpc64: performance monitor exception".  The problem is
that I am not convinced the proposed patch is safe, and in fact I
think it introduces a potential deadlock on Cell at least, but we
haven't worked out an alternative solution yet.  I hope to have a good
solution within the next couple of days.

Paul.
