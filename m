From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bill Fink <billfink@mindspring.com>,
	LinuxPPC Developers <linuxppc-dev@lists.linuxppc.org>
Subject: Re: SCSI (AIC7XXX) broken going from 2.4.19-pre8-ben0 to 2.4.19-ben0
Date: Sat, 10 Aug 2002 08:30:17 +0200
Message-Id: <20020810063017.10770@smtp.wanadoo.fr>
In-Reply-To: <20020809230936.21a3928d.billfink@mindspring.com>
References: <20020809230936.21a3928d.billfink@mindspring.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>Aug  9 13:40:34 gwiz kernel: SCSI subsystem driver Revision: 1.00
>Aug  9 13:40:34 gwiz kernel: PCI: Device 11:04.0 not available because of
>resour
>ce collisions
>Aug  9 13:40:34 gwiz kernel: mesh: configured for synchronous 5 MB/s
>Aug  9 13:40:34 gwiz kernel: kmod: failed to exec /sbin/modprobe -s -k
>scsi_host
>adapter, errno = 2
>Aug  9 13:40:34 gwiz last message repeated 3 times
>
>And no SCSI devices are available.
>
>Any ideas about what might be wrong?
>
>						-Thanks
>
>						-Bill
>
>P.S.  I am running a UP kernel on a dual 500 MHz G4 desktop.

Ah, interesting, you have a configuration that shows a problem I'm
chasing. Please, go back to the working kernel, and send me
the result of lspci -vv.

Also, if you can boot at all with the new kernel, please send me
the complete dmesg log as well.

Thanks !

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
