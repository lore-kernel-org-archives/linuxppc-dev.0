Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Message-Id: <v04103c53b2c0732c9ed0@[206.163.71.146]>
In-Reply-To: <369A7A24.50B2690F@pop.agri.ch>
Date: Tue, 12 Jan 1999 00:15:02 -0800
To: <linuxppc-dev@lists.linuxppc.org>
From: Joel Klecker <espy@debian.org>
Subject: Re: compiling option _USE_XOPEN
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 23:24 +0100 1999-01-11, Andreas Tobler wrote:
>I found an option in the header file <bits/types.h>
>it is called _USE_XOPEN. Can ANYBODY give me a hint about it??? please.

glibc's NOTES file:

<<
 - Macro: _XOPEN_SOURCE
     If you define these macro, functionality described in the X/Open
     Portability Guide is included.  This is an superset of the POSIX.1
     and POSIX.2 functionality and in fact `_POSIX_SOURCE' and
     `_POSIX_C_SOURCE' get automatically be defined.

     But as the great unifaction of all Unices there is also
     functionality only available in BSD and SVID is included.

     If the macro `_XOPEN_SOURCE_EXTENDED' is also defined, even more
     functionality is available.  The extra functions will make all
     functions available which are necessary for the X/Open Unix brand.
>>

__USE_XOPEN is the internal macro for _XOPEN_SOURCE

>I was looking to man pages, maybe the wrong ones. No success.

In general, GNU software doesn't have man pages, and even if it does, 
the texinfo docs are authoritative.
--
Joel Klecker (aka Espy)                     <URL:http://web.espy.org/>
<URL:mailto:jk@espy.org>                  <URL:mailto:espy@debian.org>
Debian GNU/Linux PowerPC -- <URL:http://www.debian.org/ports/powerpc/>

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
