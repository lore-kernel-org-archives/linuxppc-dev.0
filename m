Message-Id: <9905121524.AA32004@marc.watson.ibm.com>
To: Richard Henderson <rth@cygnus.com>
Cc: law@cygnus.com, Franz Sirl <Franz.Sirl-kernel@lauterbach.com>,
        egcs-patches@egcs.cygnus.com, meissner@cygnus.com,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: PATCH: Fix 2 PPC/SYSV varargs problems 
In-Reply-To: Message from Richard Henderson <rth@cygnus.com>
   of "Tue, 11 May 1999 23:48:42 PDT." <19990511234842.A26784@cygnus.com>
Date: Wed, 12 May 1999 11:24:15 -0400
From: David Edelsohn <dje@watson.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>>>> Richard Henderson writes:


Richard> On Wed, May 12, 1999 at 12:19:53AM -0600, Jeffrey A Law wrote:
>> Has this problem been fixed?  I see patch from Richard which looks like it
>> is related:

Richard> No, this is a different, though related, problem.  I need to sit
Richard> down with the ABI to properly evaluate the patch.  PPC SVR4 varargs
Richard> seems needlessly complex.

	That is an understatement!  PPC SVR4 varargs is a monstrosity that
attempted to pack the registers as tightly as possible and created an
endless mess as a result.

David

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
