Message-Id: <9905209271.AA927182303@smtplink.dscc.dk>
Date: Thu, 20 May 1999 07:36:45 +0200
From: "RTHEANDE"<rtheande@dscc.dk>
To: <linuxppc-dev@lists.linuxppc.org>
Subject: Stable (compilable) kernel?
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


     Hi there,
     
     I'm trying to build a kernel for a 860T MBX alike board.
     
     I can't do CVS checkout because of a firewall :(
     So I grabbed the vanilla 2.2.9 kernel but it doesen't compile. It dies 
     in mbx_setup.c because of
     1) missing headerfile (asm/8xx_immap.h)
     2) undefined MBX_IMAP_ADDR
     
     Trying to get somewere I grabbed the embedded-2.2.5 tarball from Dan. 
     It fails in m8xx_setup.c with several syntax(!) errors. Once fixed 
     there is a number of undef'ed functions...
     
     The question: where can I find a stable kernel for my config? Isn't 
     the 2.2.9 supposed to work for embedded targets (or did Linus miss 
     some syncs)?
     
     I suspect my code base for fixes should be the CVS, right?
     
     Robin.
     
     PS. I'm compiling on a Intel PC with a cross compiler but that 
     shouldn't make much of a difference.


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
