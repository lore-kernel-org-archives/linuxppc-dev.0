Date: Sat, 19 Dec 1998 11:13:17 -0700 (MST)
From: Jeff Rugen <jrugen@primenet.com>
To: Cort Dougan <cort@cs.nmt.edu>
cc: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: ns16550.[hc]
In-Reply-To: <Pine.BSI.3.96.981218070058.2404A-100000@usr07.primenet.com>
Message-ID: <Pine.BSI.3.96.981219111012.1556A-100000@usr01.primenet.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I'm building on a Motorola PowerStack from the vger tree.  The Makefile and
misc.c in arch/ppc/boot are looking for the files ns16550.h and ns16550.c,
but they don't seem to be in vger.  (I'm compiling with serial console on
and a non-MTX board -- I think those are the conditional flags that
select/deselect it).  Should those files be in vger or do I have to get them
elsewhere, or do I have a problem with my cvs setup or something?  I've did
a cvs update -A -d yesterday.


----------------------------------------------------------------------------
Jeff Rugen                      jrugen@primenet.com

..Had this been an actual emergency, we would have fled in terror, and you 
would not have been informed.


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
