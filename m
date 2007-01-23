Return-Path: <haupt.andre@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 2B69ADDF1D
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 24 Jan 2007 00:01:31 +1100 (EST)
Message-ID: <45B606CB.4050305@gmx.de>
Date: Tue, 23 Jan 2007 13:59:55 +0100
From: Andre Haupt <haupt.andre@gmx.de>
MIME-Version: 1.0
To: Manjunath AM <Manjunath.AM@Lntemsys.com>
Subject: Re: nfs mounting problem
References: <OF08754E94.1194DC2D-ON6525726C.0043EADB-6525726C.0044D6F4@lntemsys.com>
In-Reply-To: <OF08754E94.1194DC2D-ON6525726C.0043EADB-6525726C.0044D6F4@lntemsys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: kernelnewbies@nl.linux.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Manjunath AM wrote:
>
> Hi,
Hi,
>
> Looking up port of RPC 100003/2 on 192.168.178.110
> portmap: server 192.168.178.110 not responding, timed out
> Root-NFS: Unable to get nfsd port number >from server, using default
> Looking up port of RPC 100005/1 on 192.168.178.110
> portmap: server 192.168.178.110 not responding, timed out
> Root-NFS: Unable to get mountd port number from server, using default
> mount: server 192.168.178.110 not responding, timed out
> Root-NFS: Server returned error -5 while mounting 
> /opt/montavista/pro/devkit/ppc/82xx/target
> VFS: Unable to mount root fs via NFS, trying floppy.
> VFS: Cannot open root device "nfs" or unknown-block(2,0)
> Please append a correct "root=" boot option
> Kernel panic - not syncing: VFS: Unable to mount root fs on 
> unknown-block(2,0)
>  <0>Rebooting in 180 seconds..

is portmap actually running?
try ps -e | grep portmap

if it is

netstat -an | grep ":111 "

should report something like this.

tcp 0 0 0.0.0.0:111 0.0.0.0:* LISTEN
udp 0 0 0.0.0.0:111 0.0.0.0:*


Best regards,

Andre
