Message-ID: <38977960.40E014A1@zeta.org.au>
Date: Wed, 02 Feb 2000 11:25:04 +1100
From: Peter Allworth <linsol@zeta.org.au>
MIME-Version: 1.0
To: duncanp@research.canon.com.au
CC: linuxppc-embedded@lists.linuxppc.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: Low memory problems in 8xx Linux
References: <20000201235813.4F5611B51A@elph.research.canon.com.au>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


duncanp@research.canon.com.au wrote:
>
> Dan,
>
> On  1 Feb, Dan Malek wrote:
> > I have already incorporated most of these into 2.3.xx
> > kernel, and a 2.2.13 version that I will update as a tar file
> > on a server.
>
> would you mind posting a diff against the current 2.2.13 kernel on the
> ftp server when you do this as well? we've got a kernel in CVS here (i
> imagine plently of others are doing this too), and it would be easier
> for us if we can patch it.
>
> Dunk.

Dunk,

If you need the MMU patches straight-away, I've put them on

http://www.zeta.org.au/~linsol

They only work against cllf-2.2.13 for now. Marcus Sundberg has sent
me a revised patch which should work for other 2.2 kernels (caveat emptor).
I'll try to add that asap.

Cheers,

PeterA.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
