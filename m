Message-Id: <5.0.2.1.0.20010703142400.00a79ec0@pop.gmx.de>
Date: Tue, 03 Jul 2001 14:26:35 +0800
To: Tim Woo <thwoo@engmail.uwaterloo.ca>,
	linuxppc-embedded@lists.linuxppc.org
From: Michael Habermann <MHabermann@gmx.de>
Subject: Re: NFS mount root problem
In-Reply-To: <3B412551.60D20D82@engmail.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


At 09:52 PM 7/2/2001 -0400, Tim Woo wrote:
>I am unable to mount to the host.  I'm using MBX860 and I'm having
>problem to mount to the host's NFS.  Can anyone please help.  I have
>enclosed the log in the following.  Thank you very much.

Have you checked if you can mount the directory from the host PC and
another PC?
mkdir x
mount -t nfs <ip>:<dir> x
ls x

Maybe NFS is not started, or your PC has a firewall which is default at Red
Hat 7.1.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
