Message-Id: <200004121242.IAA08006@p2.parker.boston.ma.us>
To: Patrick Lerda <Lerda@microprocess.com>
cc: "'linux-kernel@vger.rutgers.edu'" <linux-kernel@vger.rutgers.edu>,
        "'linuxppc-dev@lists.linuxppc.org'" <linuxppc-dev@lists.linuxppc.org>
Subject: Re: linux 2.3.99-pre5 OOPS on NFS code (PowerP C740) (Work with 2 .3.99-pre3) 
In-reply-to: Your message of "Wed, 12 Apr 2000 11:59:31 +0200."
             <17B78BDF120BD411B70100500422FC63079F4F@IIS000>
Date: Wed, 12 Apr 2000 08:42:13 -0400
From: Brad Parker <brad@parker.boston.ma.us>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Patrick Lerda wrote:
>
>I've tried  linux 2.3.99-pre5 on my PPC740 box, and it crashs
>when the kernel mount the NFS partion to boot on. Linux 2.3.99-pre3
>works well... the NIP indicate a crash in 'xdr_decode_fhstatus.'

I posted diffs for this to the list several days ago.  Someone added
some code in the xdr decode but never tested it.  it's not the fix,
but If you remove the memset in that routine the crash will go away...

-brad

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
