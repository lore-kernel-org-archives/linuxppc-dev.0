Date: Thu, 10 Dec 1998 18:24:55 -0500 (EST)
From: Donn Ezekiel Wheeler <dwheeler@cs.umb.edu>
To: nathan ingersoll <ningerso@d.umn.edu>
cc: linuxppc-user@lists.linuxppc.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: Kernel 2.1.131
In-Reply-To: <Pine.SO4.4.02.9812100917210.132-100000@ub.d.umn.edu>
Message-ID: <Pine.GSO.4.05.9812101815030.9261-100000@eris.cs.umb.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


yeah, I experienced problems with 2.1.131 also. with mine, I compiled
everything dep clean, vmlinux and then set it up, when I rebooted it would
get to where it checks the partitions, and for some reasons decides taht
my root partition is not ext2 (however, this works perfectly fine in
2.1.24) then it drops me into single user mode, and all it can mount is my
root partition (which it didnt think was good, go figure) maybe the
devices have new and different names or the partition naming scheme is
different. god knows, 

-zk

<><><><><><><><>
Donn Ezekiel Wheeler
dwheeler@eris.cs.umb.edu
dwheeler@mars.cc.umb.edu
http://www1.shore.net/~cp/zk/zk.html

On Thu, 10 Dec 1998, nathan ingersoll wrote:

> 
> Has anyone successfully compiled and used the 2.1.131 kernel from
> ftp.kernel.org? I downloaded it and compiled it without error, but when I
> try to boot all I get is a black screen with the line "Welcome to Linux
> kernel 2.1.131" or something like that. Nothing happens after this. I did
> forget to compile and install the modules, but I don't think that would
> cause the system to hang right off the bat. Any ideas on the problem?
> 
> Thanks,
> 
> Nathan
> 
> 
> 


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
