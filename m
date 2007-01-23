Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 9FAB7DDDEC
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 24 Jan 2007 01:58:37 +1100 (EST)
Message-ID: <45B62294.5020900@ru.mvista.com>
Date: Tue, 23 Jan 2007 17:58:28 +0300
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: sudheer <urwithsudheer@gmail.com>
Subject: Re: regarding kgdb in ppc
References: <12c9fc1a0611280820h748cd520pd5546e2803dbab82@mail.gmail.com>	<d16b1c80611301101n5f9ea44died47d2ff1bac4221@mail.gmail.com>	<12c9fc1a0611302029h36f29943s119f8ad70b95f2c4@mail.gmail.com>	<12c9fc1a0612010331p2c33c048j1af6006deda14abb@mail.gmail.com>	<d16b1c80612010540k7600f0e1n92fadd3d539d75bf@mail.gmail.com>	<12c9fc1a0612040805p64f23a7bj42fd27891294dfc2@mail.gmail.com>	<458E384A.108@gmail.com>	<198592450612281634l3e71834i5915139a73e8f5d1@mail.gmail.com>	<758a2bbf0612281702u3a4f383bi14e418410bd4f912@mail.gmail.com>	<45964D27.6020708@gmail.com>	<758a2bbf0612301753q27727b01w92681214a6296434@mail.gmail.com>	<45B5A499.4060401@gmail.com>	<20070123114917.5668a578@localhost.localdomain>
	<45B61FF2.6070706@gmail.com>
In-Reply-To: <45B61FF2.6070706@gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
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

Hello.

sudheer wrote:

>> I'd consider kgdboe - it works pretty well with 8540 gianfar (or at 
>> least used to work for me so tinkering might be trivial).

> I have tried with kgdboe. The kernel doesn't wait at any point of time 
> and boots completely.

> I gave the following bootargs:
> console=ttyS0,115200 root=/dev/ram rw 
> kgdboe=@192.168.3.80/,@192.168.3.14/00:08:A1:84:EF:CA kgdbwait

    You don't have to specify the remote MAC, IIUC.

> My Host IP is 192.168.3.14 and that of target's is 80

> The whole dump of boot process is as below:

[...]
> Memory CAM mapping: CAM0=256Mb, CAM1=0Mb, CAM2=0Mb residual: 0Mb
> Linux version 2.6.15.5 (root@Sudheer) (gcc version 3.4.4) #43 Tue Jan 23 
> 15:50:57
> IST 2007
[...]
> kgdboe: local port 6443
> kgdboe: local IP 192.168.3.80
> kgdboe: interface eth0
> kgdboe: remote port 6442
> kgdboe: remote IP 192.168.3.14
> kgdboe: remote ethernet address 00:08:a1:84:ef:ca
> kgdboe: eth0 doesn't support polling, aborting.
> kgdboe: netpoll_setup failed kgdboe failed

    Have you backported the gianfar netpoll patch from 2.6.20-rc1?

> Thanks
> Sudheer

WBR, Sergei
