To: Daniel Jacobowitz <drow@mvista.com>
Cc: Vladimir Gurevich <vag@paulidav.org>,
	Kalpesh Jasapara <kjasapara@yahoo.com>, gdb@sources.redhat.com,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: GDB server and threaded application 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 26 Mar 2003 08:41:42 EST."
             <20030326134141.GA32522@nevyn.them.org>
Date: Wed, 26 Mar 2003 17:13:41 +0100
Message-Id: <20030326161346.18A0AC58BA@atlas.denx.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Daniel,

in message <20030326134141.GA32522@nevyn.them.org> you wrote:
>
> As usual, Wolfgang's answer is somewhat biased.  GDB 5.3's

As usual? C'me on!

> Neither the version originally in HHL 2.0 nor gdb 5.2.1 supported it
> however.  Kalpesh said he was trying gdb 5.3, which does.

It was not me who pointed to "our" version of the patch.

In my original posting which Vladimir quotet I  answered  a  question
which  was  exactly  about the GDB version in HHL 2.0 and gdb[server]
5.2.1.

> I would also like to offer Wolfgang a BIG KICK IN THE HEAD.  I have
> looked at the relevant path on his FTP site that you referenced below;
> despite his name as the only name on the "ChangeLog entry" in the
> README and the claim of "we spend some work", it is my work.  I wrote
> just about every line of that patch.

It is based on your patch, right. But your patch was against the  (by
then)  TOT  of  the GDB CVS. It was not very hard to back port to GDB
version 5.2 and even to 5.1.1. But yes, we _did_ spend some  work  on
this.  Basic  functionality  of remote multi-thread debugging (namely
things  as  thread  selection,  stack  backtraces,  thread  variables
printouts)  worked  okay.  But  if  I  remember right there were some
features though that were not working yet. Most notably,  these  were
asynchronous  thread  notification  (that  is, when gdbserver receive
signals upon creation of a new thread or death of an existing thread,
etc.), and single-stepping within a thread.  Again,  "we  spend  some
work".

> As usual proper credit would be appreciated.

Of course. Added to the README. Is this  OK  for  you  now?  If  not,
please send me a diff containing the text you want to see added.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
 The software required `Windows 95 or better', so I installed Linux.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
