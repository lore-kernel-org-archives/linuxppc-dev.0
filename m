Date: Mon, 14 Dec 1998 01:06:05 -0600 (CST)
From: nathan ingersoll <ningerso@d.umn.edu>
To: Piotr_Muszynski <u0295020@iwate-u.ac.jp>
cc: linuxppc-dev@lists.linuxppc.org, linuxppc-user@lists.linuxppc.org,
        owner-linuxppc-dev@lists.linuxppc.org
Subject: Re:  Kernel 2.1.131
In-Reply-To: <199812102227.HAA24931@newmsv.cc.iwate-u.ac.jp>
Message-ID: <Pine.SO4.4.02.9812140104520.3712-100000@ub.d.umn.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


For some reason, without commenting out the SMP=1 in the makefile, mine
would not continue to load the kernel. It would display the welcome and
then stop. After recompiling with this line commented out, everything
works fantastic.

Nathan


On Fri, 11 Dec 1998, Piotr_Muszynski wrote:

> 
> I have compiled with modules and use 2.1.131 from kernel.org for some time.
> Didn't have to change anything in the config to make it bootable.
> 
> Regards,
> piotru
> 
> [[ This message was sent via the linuxppc-user mailing list. Replies are ]]
> [[ not forced back to the list, so be sure to  Cc linuxppc-user  if your ]]
> [[ reply is of general interest. To unsubscribe from linuxppc-user, send ]]
> [[ the message 'unsubscribe' to linuxppc-user-request@lists.linuxppc.org ]]
> 


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
