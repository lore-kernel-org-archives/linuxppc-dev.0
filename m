Message-Id: <200008060334.XAA29546@mal-ach.watson.ibm.com>
To: Takashi Oe <toe@unlserve.unl.edu>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: a GCC question 
In-Reply-To: Message from Takashi Oe <toe@unlserve.unl.edu>
   of "Sat, 05 Aug 2000 22:20:05 CDT." <Pine.LNX.3.96LJ1.1b7.1000805220927.649I-100000@ofey.earthlink.net>
Date: Sat, 05 Aug 2000 23:34:46 -0400
From: David Edelsohn <dje@watson.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


	I do not know SVR4 that well to know what else might end up in
rodata other than symbols.  Switch jump tables are the only thing that
comes to mind.

	Even if the default is to do nothing, one always should provide a
default action or just break so that the density / coverage of the switch
statement cases is apparent.

David

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
