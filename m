Content-Type: text/plain;
  charset="iso-8859-1"
From: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
To: Chris Friesen <cfriesen@nortelnetworks.com>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: any problems with gcc 3.0/3.1 and compiling 2.4.18 on ppc?
Date: Tue, 2 Apr 2002 22:14:45 +0200
References: <3CAA0F4D.26C3A8BC@nortelnetworks.com>
In-Reply-To: <3CAA0F4D.26C3A8BC@nortelnetworks.com>
MIME-Version: 1.0
Message-Id: <200204022214.46035@enzo.bigblue.local>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tuesday 02 April 2002 22:06, Chris Friesen wrote:
> We're looking at moving to gcc 3.x for 2.4.18, and are trying to decide
> what version to use.  It appears that there were some ppc-specific fixes
> that went in to 3.1, and I'm not sure if they were ported back to 3.0.
>
> Has anyone had any successes or failures using either of these versions on
> 2.4.18 on ppc?
> Any gotchas?

Both 3.0.4 and the upcoming 3.1 are fine for use with the current PPC 2.4
kernels. There is only one known issue with inlined functions that take and
return 64-bit values, these may lead to extreme stack usage. A fix for this
might go into 3.1pre CVS during the next days.
After this has been decided I'll upload gcc-3.1pre RPMS and announce them.

Franz.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
