Message-Id: <9812071511.AA34514@marc.watson.ibm.com>
To: "Paul J. Schinder" <schinder@pobox.com>
Cc: LinuxPPC Dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: EGCS 1.1.1 FYI 
In-Reply-To: Message from "Paul J. Schinder" <schinder@pobox.com>
   of "Mon, 07 Dec 1998 21:51:00 EST." <199812071128.GAA01786@smtp2.mindspring.com>
Date: Mon, 07 Dec 1998 10:10:10 -0500
From: David Edelsohn <dje@watson.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>>>> "Paul J Schinder" writes:

Paul> So are Gary Thomas' patches still necessary?

	The trampoline patch now has become a shared library compatibility
issue for glibc-1.99 support.  It only is necessary until LinuxPPC cuts
over to glibc-2.1 which will require other binary incompatible changes at
the same time.

David

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
