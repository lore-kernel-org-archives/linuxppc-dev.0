Message-ID: <373C287A.A8E2F814@wanadoo.fr>
Date: Fri, 14 May 1999 15:43:22 +0200
From: Martin Costabel <costabel@wanadoo.fr>
Reply-To: costabel@wanadoo.fr
MIME-Version: 1.0
To: Tom Rini <tmrini@ntplx.net>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: LinuxPPC-DR-1.0: Some questions
References: <Pine.SUN.4.02.9905140830040.27935-100000@sea.ntplx.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Tom Rini wrote:
> 
> On Fri, 14 May 1999, Martin Costabel wrote:

> > 2. The following rpms were there in previous versions of pre-R5. 
[...] 
> > hfsutils
> 
> Either Jeff added that one, or it was a very old rpm.

RedHat keeps it in the powertools directory. It's not so old:

   root[54]#rpm -qp --changelog
/usr/src/redhat/SRPMS/hfsutils-3.2.6-1.src.rpm
   * Thu Apr 15 1999 Michael Maher <mike@redhat.com>

   - built package for 6.0
   - updated source

I think it would be important to have hfsutils in any linuxppc
distribution. It --rebuilds without problem.

--
Martin

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
