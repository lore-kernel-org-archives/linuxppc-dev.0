Message-ID: <19990429200222.B27844@cygnus.com>
Date: Thu, 29 Apr 1999 20:02:22 -0700
From: Richard Henderson <rth@cygnus.com>
To: Zack Weinberg <zack@rabi.columbia.edu>
Cc: meissner@cygnus.com, David Edelsohn <dje@watson.ibm.com>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: PATCH: Fix 2 PPC/SYSV varargs problems
References: <19990429194817.B20300@cygnus.com> <199904300255.WAA16851@blastula.phys.columbia.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <199904300255.WAA16851@blastula.phys.columbia.edu>; from Zack Weinberg on Thu, Apr 29, 1999 at 10:55:36PM -0400
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Apr 29, 1999 at 10:55:36PM -0400, Zack Weinberg wrote:
> ObDumbQuestion: Is this a bug we really need to fix for 1.2?  It's
> been around for awhile and all the proposed solutions are either dirty
> kludges or too invasive.

A reasonable question.  Though I don't think my last patch is either.

It certainly isn't invasive; as for kludginess, it's in good company
with the way the alpha port has done things for a long time.  Infer
what you will with that.  ;-)


r~

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
