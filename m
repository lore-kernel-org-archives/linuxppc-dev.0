Subject: Re: NFS mounting timeout
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
Date: Mon, 13 Aug 2001 11:47:15 +0200
Message-ID: <566C53CBBECCFF4D8D31B380F7B345FB016647@PICARD.nc1701.de>
From: "Frank Przybylski" <fp@vas-gmbh.de>
To: "Pawel Zawora" <pzawora@fideltronik.com>,
	<linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Pawel,

> I use rom file system as a root fs. When I try to mount nfs in my root
> fs an error occurs.
> (mount -t nfs 192.168.1.1:/nfs /nfs)
> After about 2 minutes kernel writes: "portmaper: time out".
> What I should do?

Check if the portmapper is running (both sides, server AND client), if
not start it (usually /sbin/portmap).

hth
 Frank

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
