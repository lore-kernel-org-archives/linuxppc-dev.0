Message-Id: <200101210058.TAA27346@mal-ach.watson.ibm.com>
To: Brad Parker <brad@parker.boston.ma.us>
cc: khendricks@ivey.uwo.ca, Andy Johnson <andyj@mc.com>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: Issue with small struct return values 
In-Reply-To: Message from Brad Parker <brad@parker.boston.ma.us>
   of "Sat, 20 Jan 2001 19:44:16 EST." <200101210044.TAA64354@p2.parker.boston.ma.us>
Date: Sat, 20 Jan 2001 19:58:57 -0500
From: David Edelsohn <dje@watson.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>>>> Brad Parker writes:

Brad> translation?  object files from ibm's c compiler won't work when linked
Brad> with object files from gcc...

Brad> who's ox are we stabbing here?  :-)

	If you were not being such a cynic, you might realize that there
are other vendors with commercial SysV and eABI compilers for PowerPC.
GCC does not work with any of the others, or people who hand-code assembly
for the ABI, like JITs.

	I guess that PowerPC Linux does not want to use anyone else's
commercial software.

David

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
