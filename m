Date: Tue, 31 Jul 2001 02:01:35 -0700 (PDT)
From: James F Dougherty <jfd@GigabitNetworks.COM>
Message-Id: <200107310901.CAA02948@krakatoa.gigabitnetworks.com>
To: mgreer@mvista.com, trini@kernel.crashing.org,
	jfd@GigabitNetworks.COM, jfd@krakatoa.gigabitnetworks.com
Subject: Re: HHL 2.0 login problem
Cc: jfd@GigabitNetworks.COM, linuxppc-embedded@lists.linuxppc.org,
	ppcboot-users@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


INIT: version 2.78 booting
eth0: Setting full-duplex based on MII#0 link partner capability of 45e1.
INIT: Entering runlevel: 2

Linux 2.0 (linux-2.4.2_hhl20)





mousse login: root
PAM_unix[14]: (login) session opened for user root by (uid=0)

Linux 2.0 (MontaVista HLL2.0)

MOUSSE/MPC8240



login[14]: unable to change tty `/dev/console' for user `root'

Unable to change tty /dev/console: Illegal seek


Linux 2.0 (linux-2.4.2_hhl20)



mousse login:



> Content-MD5: rWhRYjSxD0fPNTrP1f0TsA==
>
> Anyone know what is wrong here? Perhaps my dev tree is not
> configured correctly, or there is some missing file?
>
>
>
> VFS: Mounted root (nfs filesystem).
> Freeing unused kernel memory: 84k init 4k openfirmware
> modrs_close: bad serial port count; tty->count is 1, state->count is 2
> probe: modprobe: Can't open dependencies file
> /lib/modules/2.4.2_hhl20/modules.dep (No such file or directory)
> INIT: version 2.78 booting
> eth0: Setting full-duplex based on MII#0 link partner capability of 45e1.
> INIT: Entering runlevel: 2
>
> mousse login: root
>
> PAM_unix[14]: (login) session opened for user root by (uid=0)
> login[14]: unable to change tty `/dev/console' for user `root'
> Unable to change tty /dev/console: Illegal seek
>
> mousse login:

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
