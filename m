Message-Id: <200101210044.TAA64354@p2.parker.boston.ma.us>
To: David Edelsohn <dje@watson.ibm.com>
cc: khendricks@ivey.uwo.ca, Andy Johnson <andyj@mc.com>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: Issue with small struct return values 
In-reply-to: Your message of "Sat, 20 Jan 2001 16:37:33 EST."
             <200101202137.QAA22694@mal-ach.watson.ibm.com>
Date: Sat, 20 Jan 2001 19:44:16 -0500
From: Brad Parker <brad@parker.boston.ma.us>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


David Edelsohn wrote:
>	This issue does matter because this mistake harms PowerPC
>performance on these systems, and because other commercial compilers
>implement the ABI correctly which causes this GCC mistake to interfere
>with interoperability.

translation?  object files from ibm's c compiler won't work when linked
with object files from gcc...

who's ox are we stabbing here?  :-)

-brad


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
