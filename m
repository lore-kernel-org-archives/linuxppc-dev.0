Message-Id: <9904300308.AA40106@marc.watson.ibm.com>
To: Richard Henderson <rth@cygnus.com>,
        Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
Cc: Zack Weinberg <zack@rabi.columbia.edu>, meissner@cygnus.com,
        linuxppc-dev@lists.linuxppc.org, egcs-patches@egcs.cygnus.com
Subject: Re: PATCH: Fix 2 PPC/SYSV varargs problems 
In-Reply-To: Message from Richard Henderson <rth@cygnus.com>
   of "Thu, 29 Apr 1999 20:02:22 PDT." <19990429200222.B27844@cygnus.com>
Date: Thu, 29 Apr 1999 23:08:18 -0400
From: David Edelsohn <dje@watson.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>>>> Richard Henderson writes:

Richard> It certainly isn't invasive; as for kludginess, it's in good company
Richard> with the way the alpha port has done things for a long time.  Infer
Richard> what you will with that.  ;-)

	I am much more comfortable with a patch along the lines of
Richard's proposal -- both in the short term for egcs-1.2 release and as a
long-term solution.  I do not think that there is an elegant way to fix
this. 

David

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
