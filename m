Message-Id: <37D8DE44.9AE2C717@ssl.co.uk>
Date: Fri, 10 Sep 1999 11:32:36 +0100
From: Sacha Varma <sacha@ssl.co.uk>
Mime-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: altivec
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Has any progress been made on LinuxPPC Altivec support? I posted a while back
and there was some discussion, I wondered if anyone was taking it further. I
suppose the arrival of G4 Macs in a few weeks' time will help kickstart things.
It would be great if AIM took the lead in this sort of work...

The issues as I remember them:

.. saving/restoring altivec registers (there's sample machine
  code for one of the ABIs in the Altivec documentation)

.. support in egcs for the Altivec C language extensions, 
  hopefully C++ also (someone said they had patches supplied
  by Motorola, but I've not found mention of these on the
  Motorola SPS site so I assume they're not for general
  consumption)


There was some talk of trapping an illegal instruction interrupt in
Altivec-compiled code on non-Altivec processors and then emulating it in
software, but as I recall this was thought to be maybe impossible (due to
limited information about the illegal instruction and limits on what you can do
in the trap) or more effort than it's worth.


In the meantime to learn more about Altivec I've been working on a library to
emulate the instructions in software (with appropriate #defines for the language
extensions in a header). If anyone's interested e-mail me and I'll let you know
if/when I'm done; I'm hoping to get the bulk of it done this weekend. (It'll be
C++ I'm afraid - the vector types lend themselves nicely to a template class,
and a lot of the vec_* instructions are overloaded).


--
sacha varma : system simulation ltd : sacha@ssl.co.uk

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
