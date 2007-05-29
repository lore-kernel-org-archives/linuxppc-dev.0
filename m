Return-Path: <akonovalov@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id 1CED4DE1AB
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 30 May 2007 00:51:27 +1000 (EST)
Message-ID: <465C3F5E.6000504@ru.mvista.com>
Date: Tue, 29 May 2007 18:57:34 +0400
From: Andrei Konovalov <akonovalov@ru.mvista.com>
MIME-Version: 1.0
To: Mohammad Sadegh Sadri <mamsadegh@hotmail.com>
Subject: Re: Kernel 2.6, ML403, rootfs on nfs, gigabit ethernet link, nfs
	mount	problems
References: <BAY115-W173A643AF082D78122CB6DB22F0@phx.gbl>
In-Reply-To: <BAY115-W173A643AF082D78122CB6DB22F0@phx.gbl>
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Cc: Linux PPC Linux PPC <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Mohammad Sadegh Sadri wrote:
> Hi all,
> 
> well I could bring up the grant's kernel on ml403 completely. the root file system was over nfs. 
> 
> when I use a 100mbits link for connection to ml403 , every thing is working suitably.
> but when I use a 1000mbits link, I see that ml403 gets ip address from dhcp and mounts the root file system but can not go further , it stops with a message: "nfs server not responding ...." some thing like this.
> 
> when pinging to ml403 with 64 bytes packets, ping works fine for both of 100 and 1000mbits links
> but when I try to ping the board with 4000 bytes packets I notice that ml403 on gigabit link can not answer to ping packets, however on 100mbit link every thing works just fine.
> 
> any ideas?

TEMAC is in FIFO mode?
Try adding "nfsroot=,rsize=1024,wsize=1024" to cmdline?

Thanks,
Andrei
