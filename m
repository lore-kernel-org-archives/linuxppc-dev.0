Date: Mon, 25 Oct 1999 13:08:49 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: luther@dpt-info.u-strasbg.fr
cc: Sean Chitwood <darkmane@w-link.net>,
        LinuxPPC Developers List <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Modern PowerPC Assembly?
In-Reply-To: <19991025101727.A4528@maxime.u-strasbg.fr>
Message-ID: <Pine.HPX.4.10.9910251300440.21757-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Mon, 25 Oct 1999, Sven LUTHER wrote:

> Gabriel, ...
> 
> Do you think it would be possible to use your emulator to have a ppc
> based dosemu ?

Well, this is real mode only... So plain DOS, I have ideas to add
protected mode and _efficient_ paging, but no time to do so. This would
unfortunately significantly bloat the code. There is also no FPU. The most
positive points of this emulator are the compact size and perhaps also
reasonable speed (if what I've heard about other emulators is true),
approximately equivalent to a 33MHz 386DX on a 200MHz 603e.

	Regards,
	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
