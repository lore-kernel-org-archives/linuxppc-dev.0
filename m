Date: Tue, 12 Jan 1999 16:26:31 +0100
From: Hubert Figuiere <Hubert.Figuiere@solsoft.fr>
To: linuxppc-dev@lists.linuxppc.org
Subject: Porting to NuBus PowerMacs
Message-ID: <19990112162631.B29622@dirkpitt.solsoft.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



I'd like to know what would be the complexity of porting LinuxPPC
to NuBus PowerMacs ?

Here are my thoughts:

-we have BootX. So we can BootX LinuxPPC. We just need to build a
 fake OpenFirmware device tree for BootX so he can pass it the
 kernel

-we have the source of the Mach MicroKernel, hence we have enough
 to rewrite the specification to rewrite drivers for LinuxPPC.
 Some components and drivers may directly come from Linux Mac68k.


Note that I don't have a NuBus PowerMac. Only a 6200 (and my
PowerCenter Pro, already supported).

Any comments ?

Hub
-- 
> Je souhaiterais essayer Internet Explorer 4.0 sous Linux.
> Il existe 2 versions: une sous HP/UX et une sous Solaris
> Laquelle dois je utiliser?
-+- MJM in Guide du linuxien pervers : "Choisir son environnement" -+-

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
