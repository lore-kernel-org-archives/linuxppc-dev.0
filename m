From: m.venkatraj@exgate.tek.com
Message-ID: <301A812E6528D511A8F70008C71E578601FCF559@ap-bang-m02.india.tek.com>
To: wd@denx.de
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: RE: problems with NFS root for ADS860 
Date: Thu, 11 Mar 2004 00:20:16 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello Wolfgang,

> Instead of seaching the web a simple local lookup would have done:
>
> -> grep 101 /usr/include/*/errno.h
> /usr/include/asm/errno.h:#define        ENETUNREACH     101
>   /* Network is unreachable */
>
> "Network is unreachable". Does that ring a bell?

Thanks a lot!
Coming to think of it, my box and the NFS server are not on the same subnet.
Could this be an issue?

The box has IP 192.158.98.116, whereas the server is 192.158.97.38. But then
I am specifying the net mask as 255.255.252.0, also tried 255.255.0.0.
Neither helped.

The box IS able to read from the network, because u-boot picks up the kernel
image via tftp from the same server. I am clueless....

Thanks a ton for helping me thru.

Venkat


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
