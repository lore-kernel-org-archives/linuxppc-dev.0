Date: Thu, 10 Dec 1998 19:53:26 -0600 (CST)
From: nathan ingersoll <ningerso@d.umn.edu>
To: "George J. Mpitsos" <gmpitsos@slugo.hmsc.orst.edu>
cc: linuxppc-user@lists.linuxppc.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: Kernel 2.1.131
In-Reply-To: <199812102252.OAA06277@Slugo.hmsc.orst.edu>
Message-ID: <Pine.SO4.4.02.9812101952290.7215-100000@ub.d.umn.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Thanks to everyone that responded. This did the trick. Maybe next time
I'll read the docs first ;-)


On Thu, 10 Dec 1998, George J. Mpitsos wrote:

>  
> Comment out the line "SMP=1" in the make file.
> 
> 
> > 
> > 
> > Has anyone successfully compiled and used the 2.1.131 kernel from
> > ftp.kernel.org? I downloaded it and compiled it without error, but when I
> > try to boot all I get is a black screen with the line "Welcome to Linux
> > kernel 2.1.131" or something like that. Nothing happens after this. I did
> > forget to compile and install the modules, but I don't think that would
> > cause the system to hang right off the bat. Any ideas on the problem?
> > 
> > Thanks,
> > 
> > Nathan
> > 
> > 
> > 
> 


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
