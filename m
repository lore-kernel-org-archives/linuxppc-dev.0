Message-ID: <19990511234842.A26784@cygnus.com>
Date: Tue, 11 May 1999 23:48:42 -0700
From: Richard Henderson <rth@cygnus.com>
To: law@cygnus.com, Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
Cc: egcs-patches@egcs.cygnus.com, meissner@cygnus.com,
        David Edelsohn <dje@watson.ibm.com>, linuxppc-dev@lists.linuxppc.org
Subject: Re: PATCH: Fix 2 PPC/SYSV varargs problems
References: <4.2.0.37.19990430013458.0489a950@mail.lauterbach.com> <6498.926489993@upchuck.cygnus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6498.926489993@upchuck.cygnus.com>; from Jeffrey A Law on Wed, May 12, 1999 at 12:19:53AM -0600
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, May 12, 1999 at 12:19:53AM -0600, Jeffrey A Law wrote:
> Has this problem been fixed?  I see patch from Richard which looks like it
> is related:

No, this is a different, though related, problem.  I need to sit
down with the ABI to properly evaluate the patch.  PPC SVR4 varargs
seems needlessly complex.

Franz, could you point me at the test cases for this?


r~

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
