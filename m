Date: Mon, 17 Jun 2002 10:20:18 -0400
Message-Id: <200206171420.g5HEKII01583@hyper.wm.sps.mot.com>
From: Peter Barada <pbarada@mail.wm.sps.mot.com>
To: vandana_mehtani123@rediffmail.com
Cc: linuxppc-embedded@lists.linuxppc.org, Sukesh.Acharya@siritech.com
In-reply-to: <20020615093055.30142.qmail@webmail9.rediffmail.com>
	(vandana_mehtani123@rediffmail.com)
Subject: Re: linker linux
References: <20020615093055.30142.qmail@webmail9.rediffmail.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>hello everybody,
>i wanted to know where to find the address where  the
>linker links whan i link it,,
>or what is the address where linker places the code
>after linking..

You could always look at the linker map. (Add -Wl,-Map,vmlinux.map to the gcc
command line that links together vmlinux to have the linker generate
the map in vmlinux.map)


--
Peter Barada                                   Peter.Barada@motorola.com
Wizard                                         781-852-2768 (direct)
WaveMark Solutions(wholly owned by Motorola)   781-270-0193 (fax)

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
