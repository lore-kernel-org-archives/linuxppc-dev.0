Message-ID: <37B0068E.C8853FC3@wanadoo.fr>
Date: Tue, 10 Aug 1999 13:01:34 +0200
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: Hollis R Blanchard <hollis+@andrew.cmu.edu>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: cvs.on.openprojects.net status?
References: <Pine.LNX.3.96L.990809183523.5833A-100000@unix47.andrew.cmu.edu>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hollis R Blanchard wrote:
> 
> What's the deal with the CVS tree? The kernel I compiled from it a week or so
> ago has a very screwed platinumfb driver, but now the cvs server
> cvs.on.openprojects.net does not exist. www.openprojects.net has moved to
> openprojects.nu, but no mention made of CVS anywhere...
> 
> Is it just a matter of waiting for it to get set up again, or should I be
> looking elsewhere?

The cvs server is alive again now, and the linux_2_2 branch has moved to
2.2.11 with a great many updates.

The kernel doesn't compile, though. There is a new line

  EXPORT_SYMBOL(init_task_union);

in kernel/ksyms.c which conflicts with the same line in
arch/ppc/kernel/ppc_ksyms.c. One of the two has to go.

The kernel compiles then. It doesn't boot, though. On my 6400, it gets
as far as
  INIT: version 2.74 booting
and then hangs. The 2.2.10 compiled with the same config options boots
OK.

Seems that not much testing for the PPC is going on for the vger tree.

--
Martin

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
