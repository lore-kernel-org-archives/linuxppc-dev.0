Message-Id: <200007101517.LAA29422@mal-ach.watson.ibm.com>
To: daniel.marmier@lightning.ch
cc: Dan Malek <dan@netx4.com>, linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Help with string.S 
In-Reply-To: Message from Daniel Marmier <daniel.marmier@lightning.ch>
   of "Mon, 10 Jul 2000 08:14:57 +0200." <396969E1.A7256E4A@lightning.ch>
Date: Mon, 10 Jul 2000 11:17:02 -0400
From: David Edelsohn <dje@watson.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>>>> Daniel Marmier writes:

Daniel> IIRC, I have sent you a patch that did the right thing for 16-byte
Daniel> cache lines at time of 2.3.99-pre5. So this is a known problem and
Daniel> had already been fixed. Of course, if there are caches with 64 or
Daniel> 128 byte lines, some more work needs to be done.

	Current 64-bit PowerPC chips use a cacheline size of 128 bytes.
Assuming 32 bytes or 32 bytes and 16 bytes or any small number of values
is a mistake.

David

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
