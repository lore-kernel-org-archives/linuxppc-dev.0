Date: Tue, 9 Feb 1999 12:59:24 +1100
Message-Id: <199902090159.MAA04789@tango.anu.edu.au>
From: Paul Mackerras <paulus@cs.anu.edu.au>
To: mavpion@fire.csua.ucla.edu
CC: linuxppc-dev@lists.linuxppc.org, mavpion@fire.csua.ucla.edu
In-reply-to: <Pine.LNX.3.96.990201154257.111F-100000@fire.csua.ucla.edu>
	(message from Eric Guenterberg on Mon, 1 Feb 1999 15:53:25 -0800
	(PST))
Subject: Re: Linux 2.2.1 Kernel scsi troubles
Reply-to: Paul.Mackerras@cs.anu.edu.au
References: <Pine.LNX.3.96.990201154257.111F-100000@fire.csua.ucla.edu>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Eric Guenterberg <mavpion@fire.csua.ucla.edu> wrote:

> I recently compiled the the Linux 2.2.1 kernel, but I can't get it to boot
> because when it is booting it aborts the reading of the harddrive that
> contains my root partition.
> 
> I have a PowerMac 7600/132
[snip]
> It says:
> scsi host 0 aborted

Could you try the kernel (vmlinux.gz) in
ftp://samba.anu.edu.au/pub/linux-pmac/test/
and let me know if it does the same thing?

Paul.

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
