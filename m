Message-ID: <3B97B0B9.4ADDFF9F@mvista.com>
Date: Thu, 06 Sep 2001 12:22:01 -0500
From: Mark Hatle <fray@mvista.com>
MIME-Version: 1.0
To: James F Dougherty <jfd@GigabitNetworks.COM>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: SysVInit (RC Scripts) on HHL 2.0
References: <200109061710.KAA13165@krakatoa.gigabitnetworks.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


James F Dougherty wrote:

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
> Is there some bug in HHL 2.0 on ppc_82xx I don't know about?

See the HHL-JE-20.pdf file located in the (doc) documentation
directory.  I point you at Chapter 7, Additional Configuration
Information.  (Specifically at the initdconfig section.)

Assuming you used the installer, only the init scripts required to boot
a minimal system (and be able to telnet in and use nfs root) are
enabled.  Anything beyond that you, the developer/user will need to
enable.  If you did not use the installer, you probably got a bunch of
messages during installation such as "Unable to enable initd service:
checkfs.sh".  These messages mean that the initdconfig program was not
able to be run for some reason or another, thus you probably don't have
ANY initscripts installed.

The initscripts are further discussed in the "Initscript Overview"
section of Chapter 7.

--Mark
MontaVista Software, Inc.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
