Message-ID: <3B97B053.5050201@mvista.com>
Date: Thu, 06 Sep 2001 10:20:19 -0700
From: Matthew Locke <mlocke@mvista.com>
MIME-Version: 1.0
To: James F Dougherty <jfd@GigabitNetworks.COM>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: SysVInit (RC Scripts) on HHL 2.0
References: <200109061710.KAA13165@krakatoa.gigabitnetworks.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


sounds like a user error during installation.  try using the installer,
otherwise you have to figure out the dependancies by hand.

James F Dougherty wrote:

> Hi,
>
> I am using HHL 2.0 (2.4.2) on MPC8240 and I downloaded
> the root filesystem RPM's from
>
> ftp://ftp.mvista.com/pub/Journeyman/cd2/ppc_82xx/apps/*.rpm
>
> and installed them on my root filesystem.
>
> Question: How come none of the init scripts work?
>
> I have to run:
>
> devfsd /dev
> mount -a
>
> every time I boot. It spawns a getty, but none of the rc
> files get called ...
>
>
> Is there some bug in HHL 2.0 on ppc_82xx I don't know about?
>
> 			Thanks,
> 			-James
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
