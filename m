Message-Id: <200004261658.MAA22540@mal-ach.watson.ibm.com>
To: Elizabeth Clarke <eclarke@aminocom.com>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: glibc-2.1.2 cross-compile problem 
In-Reply-To: Message from Elizabeth Clarke <eclarke@aminocom.com>
   of "Wed, 26 Apr 2000 14:37:25 -0000." <3906FF25.4E9E6AEA@aminocom.com>
Date: Wed, 26 Apr 2000 12:58:39 -0400
From: David Edelsohn <dje@watson.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


	The cross-tools want to have the target system header files
available in a directory called "sys-include" underneath the target
triplet in the installation directory.  The target triplet directory wants
to look like /usr on the real system and the gcc-fixed header files will
go into the regular "include" directory.

David

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
