Date: Wed, 9 Jun 1999 10:39:44 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: David De Ridder <david.de.ridder@bitsmart.com>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.2.9 patch for Motorola support.
In-Reply-To: <3.0.6.32.19990608182608.0089b480@sins.uia.ac.be>
Message-ID: <Pine.HPP.3.96.990609100216.27048N-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Tue, 8 Jun 1999, David De Ridder wrote:

> I have a suggestion for your PRePboot patches. (I don't know whether you've
> already incorporated it in the latest patch, since I don't have access to
> the patched source tree right now).
> 
> It's something that could make people using root NFS on MVME boards (like
> the MVME230x series) happy and their lives easier ;-)
> 
> You could do something like (in pseudo-C) :
> 
> #ifdef CONFIG_ROOT_NFS
>  strcpy(kernelarguments,"console=ttyS0 root=/dev/nfs");
> #else
>  strcpy(kernelarguments,"console=ttyS0");
> #endif
> 
> As I said, I don't have the sources right now, but I think
> you see what I mean. This way people who use NFS for their
> root file system do not have to type "root=/dev/nfs".
> It's hardly a 'patch', but it could make life easier...

Indeed, but I was rather thinking of stealing some of Corey's patches
and use a global NVRAM variable which you can set with GEVEDIT under
PPCbug.

The only minor problem I have with his patch is that it uses the name
'bootargs' which is a standard OF parameter AFAIR. But what if you want to
switch between various OS ?  I would rather have used linux-bootargs or
something like that to avoid possible confusion. 

	Regards,
	Gabriel.


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
