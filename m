Message-Id: <9907301512.AA32890@marc.watson.ibm.com>
To: trevor@ica.net
Cc: LinuxPPC dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: creating EABI stack frames 
In-Reply-To: Message from trevor <trevor@ica.net>
   of "Fri, 30 Jul 1999 06:30:01 EDT." <37A17EA6.C3D20B38@ica.net>
Date: Fri, 30 Jul 1999 11:12:36 -0400
From: David Edelsohn <dje@watson.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


	Linux/PPC uses SVR4 ABI for PowerPC.  Linux/PPC originally was
developed using eABI which is a more restrictive variant of SVR4, but it
has transitioned to standard SVR4.  SVR4 and eABI stacks look identical.

	For a description of the stack frame, see the file
gcc/config/rs6000.c in the GCC distribution.  Just above the function
rs6000_stack_info() is a picture, like the ones in your message, showing
the layout of an AIX, SVR4, and Windows/NT (discontinued) stack on
PowerPC. 

	The current release of GCC does have some argument alignment
problems and stdarg/varargs is very complicated for SVR4/PPC.  The
alignment problems may be fixed in gcc-2.95.1, but I cannot guarantee
that. 

David


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
