Message-Id: <3785DD1F.B853E731@ssl.co.uk>
Date: Fri, 09 Jul 1999 12:29:35 +0100
From: Sacha Varma <sacha@ssl.co.uk>
Mime-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: altivec
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Some questions about altivec & LinuxPPC:

1. is there a free C compiler supporting altivec instructions for
   linuxPPC?

2. would it be possible to trap altivec instructions on a non-altivec
   processor and reroute them through code using generic instructions?
   (I believe this is how Apple's MacOS altivec simulator does it).
   Presumably there is a bad instruction interrupt or something and
   code in the kernel to trap these interrupts? (Excuse my naivety;
   I'm more of a kernel user than hacker - for now!)

3. has anyone written a C library to simulate the altivec instructions?

--
sacha varma : system simulation ltd : sacha@ssl.co.uk

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
