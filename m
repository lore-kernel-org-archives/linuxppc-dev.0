Message-Id: <200008060457.AAA28180@mal-ach.watson.ibm.com>
To: Takashi Oe <toe@unlserve.unl.edu>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: a GCC question 
In-Reply-To: Message from Takashi Oe <toe@unlserve.unl.edu>
   of "Sat, 05 Aug 2000 23:05:14 CDT." <Pine.LNX.3.96LJ1.1b7.1000805224207.649J-100000@ofey.earthlink.net>
Date: Sun, 06 Aug 2000 00:57:43 -0400
From: David Edelsohn <dje@watson.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>>>> Takashi Oe writes:

>> Even if the default is to do nothing, one always should provide a
>> default action or just break so that the density / coverage of the switch
>> statement cases is apparent.

Takashi> I don't know what the density is, but, if having a default action for
Takashi> nothing is always prefered, I'll fix it (or rather I'll ask Ben to fix
Takashi> it.)  Is it in gcc documentation or C standard somewhere?

	It's not in the documentation or in the standard.  It is good, but
not a requirements.  It helps document that the programmer knows what is
expected and sometimes helps the compiler generate better code by knowing
what cases need be considered.

David

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
