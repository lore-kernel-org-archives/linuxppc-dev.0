Message-ID: <20011113071701.21257.qmail@dag.newtech.fi>
To: James F Dougherty <jfd@krakatoa.gigabitnetworks.com>
Cc: dan@embeddededge.com, dag@newtech.fi, sparc64@rediffmail.com,
	ashisha@india.infogain.com, linuxppc-embedded@lists.linuxppc.org,
	dag@newtech.fi
Subject: Re: "OpenPIC versus EPIC" in MPC8240 ! 
In-Reply-To: Message from James F Dougherty <jfd@krakatoa.gigabitnetworks.com>
   of "Mon, 12 Nov 2001 22:42:04 PST." <200111130642.fAD6g4Zp019615@krakatoa.gigabitnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 13 Nov 2001 09:17:01 +0200
From: Dag Nygren <dag@newtech.fi>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>
> I've been watching this thread for quite some
> time now. I spoke with Dan about adding some
> changes to this code last summer. I ran into
> some issues with OpenPIC as well on our MPC8240
> platform.
>
>
> If you guys would like to forward me your changes,
> I can merge your changes into mine (or see if they
> are relevant) and give you an interim release.
>
> Might I ask, could you describe the architecture
> of your MPC8240 IRQ mapping and IO devices?

My changes doesn't specifically touch the MPC8240 code
but are included in my port for ths VG4-board.
This board uses a MPC107, which also is an EPIC.
The stuff was posted in this NG (and also linux-developers)
and I think you can find it there. If not give me another
mail , and I will send it to you.

What it does is really only changing the interface to
openpic_init() to something more versatile/generic/useful(?).

The interface structure could/should probably be further
abstracted to multilevel cascades (any of those out there ?)
as Dan sort of pointed out, but this is a start anyway.

The appropriate files for you from the port should be
the following:
openpic2.c and openpic2.h.

You could check the vg4_setup.c for an example of
how to use the interface.

Your mileage may vary, but it works perfectly on my board.

BRGDS

Dag


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
