Message-Id: <9902151742.AA37298@marc.watson.ibm.com>
To: Gabriel Paubert <paubert@iram.es>
Cc: Benjamin Herrenschmidt <bh40@calva.net>, linuxppc-dev@lists.linuxppc.org
Subject: Re: your mail 
In-Reply-To: Message from Gabriel Paubert <paubert@iram.es>
   of "Mon, 15 Feb 1999 15:18:01 +0100." <Pine.HPP.3.96.990215145041.5352j-100000@gra-ux1.iram.es>
Date: Mon, 15 Feb 1999 12:42:55 -0500
From: David Edelsohn <dje@watson.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>>>> Gabriel Paubert writes:

Gabriel> Ok, better like this. Unfortunately for rlwinm and friends, gas allows you
Gabriel> to replace the last 2 parameters by a single value (bit mask), for
Gabriel> example: rlwinm r3,r4,0, 0x00ffff00, but it does not work if you have the
Gabriel> complementary mask (ones, zeros, ones) so you can't type rlwinm
Gabriel> r0,r0,0,~MSR_EE. Note that gcc/egcs would generate the code with the
Gabriel> rlwinm instruction. Anybody wants to tweak binutils to allow this ?

	I think that this already was discovered and fixed in the
development sources.  From the ChangeLog:

Wed Aug 12 14:00:38 1998  Ian Lance Taylor  <ian@cygnus.com>

        From Peter Thiemann <thiemann@informatik.uni-tuebingen.de>:
        * ppc-opc.c (insert_mbe): Handle wrapping bitmasks.
        (extract_mbe): Likewise.

David

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
