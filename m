Message-Id: <3.0.6.32.19990608182608.0089b480@sins.uia.ac.be>
Date: Tue, 08 Jun 1999 18:26:08 +0200
To: Gabriel Paubert <paubert@iram.es>
From: David De Ridder <david.de.ridder@bitsmart.com>
Subject: Re: 2.2.9 patch for Motorola support.
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <Pine.HPP.3.96.990607140855.27048C-100000@gra-ux1.iram.es>
References: <Pine.LNX.3.96.990526163555.23472S-100000@fwrsl-11.phx.mcd.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I have a suggestion for your PRePboot patches. (I don't know whether you've
already incorporated it in the latest patch, since I don't have access to
the patched source tree right now).

It's something that could make people using root NFS on MVME boards (like
the MVME230x series) happy and their lives easier ;-)

You could do something like (in pseudo-C) :

#ifdef CONFIG_ROOT_NFS
 strcpy(kernelarguments,"console=ttyS0 root=/dev/nfs");
#else
 strcpy(kernelarguments,"console=ttyS0");
#endif

As I said, I don't have the sources right now, but I think
you see what I mean. This way people who use NFS for their
root file system do not have to type "root=/dev/nfs".
It's hardly a 'patch', but it could make life easier...

Kind regards,

+-----------------------------------------------------------------+
  David 'Septimus' De Ridder       <david.de.ridder@bitsmart.com> 

"I want you to find happiness."
 - Marilyn Monroe in 'Gentlemen prefer Blondes'

+-----------------------------------------------------------------+
  


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
