Date: Fri, 22 Jan 1999 10:16:50 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: Vinai <vroopcha@post.its.mcw.edu>
cc: linuxppc-user@lists.linuxppc.org, linux-pmac@samba.anu.edu.au,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: MP machine with VME bridge ??
In-Reply-To: <Pine.SOL.3.96.990121203832.18026A-100000@post.its.mcw.edu>
Message-ID: <Pine.HPP.3.96.990122101452.2291C-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Thu, 21 Jan 1999, Vinai wrote:

> 
> Hi All,
> 
> I am trying to collect some information here.  We currently have a high-
> speed data acquisition system (16-bit, 2E6 samples per sec) running on a
> Power Challange (multiple CPU Sili-graph machine with a VME bus). We are
> trying to create a duplicate system, but would very much like to avoid
> paying what we did for the Sili-graph.
> 
> Are there any multiple-CPU VME motorola based machines out there that'll
> run LinuxPPC?  Our only other alternative is linux running on a multiple
> -CPU intel machine.  But as yet we have not been able to find a PCI card
> that has the A/D performance we currently have with our present VME set-
> up.

I don't know if the MVME4600 will run right now. I'm running on MVME2600
with a preliminary Universe driver (still does not support DMA). Other
people are working on SMP support for MTX boards, which are very similar
to MVME4600 (same chipset, only no VME bridge).

Hope this helps.

	Regards,
	Gabriel.


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
