Date: Wed, 21 Apr 1999 18:08:57 +0200 (CEST)
From: Alexander Larsson <alex@signum.se>
To: Dan Malek <dmalek@jlc.net>
cc: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Embedded 8xx 2.2.5 kernel tarball
In-Reply-To: <37164E34.9B29EDBE@jlc.net>
Message-ID: <Pine.LNX.4.04.9904211803010.6664-100000@tammy.signum.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Thu, 15 Apr 1999, Dan Malek wrote:

> To all of you that have been asking lately........
> 
> I have finally uploaded the tar image of the directory I am using for the
> 8xx updates.  I have not checked in all of these changes to CVS as I
> still have to do my best to ensure I have not broken something.
> 
> Some of you have indicated you wish to contribute modifications, so please
> implement them against this source base and send me the patches or files.
> 
> When you use this kernel, I would appreciate hearing of success as well
> as failure.

I just merged my local changes with the 2.2.5-embedded sources.
I get an error when starting init. (Booting from nfs.)

It just says: 
Freeing unused kernel memory: 32k init
put_dirty_page: page already exists

and hangs. I tried to disable the SASH thing, but that made no difference.
I haven't had time to check more, gotta go home now. 
Do you have any idea?

/ Alex



[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
