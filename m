Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <000b01c0d795$c3e15f80$8021690a@huawei.com>
From: "machael thailer" <dony.he@huawei.com>
To: "Michael Habermann" <MHabermann@gmx.de>
Cc: <linuxppc-embedded@lists.linuxppc.org>
References: <5.0.2.1.0.20010508085652.00a4aec0@pop.gmx.de> <5.0.2.1.0.20010508155109.00a01ec0@pop.gmx.de>
Subject: Re: Uncompress Ok, but cannot run linux kernel...
Date: Tue, 8 May 2001 16:06:19 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>
> At 09:16 PM 5/7/2001 -0400, Dan Malek wrote:
>
> > > I have the same problem on an FADS board.
> >
> >What "same" problem?  How are you loading and tracing the kernel?
>
> The same problem is that the kernel doesn't survive until the welcome
> messge is printed.
> The kernel is loaded with ppcboot and the tftpboot commando. To trace, I
> used mpc8bug.
>
> I use the Montavista linux-2.4.0-test2-1.2.0-1 kernel.
> I set a breakpoint at the entry of the __start routine. After passing
> the turn_on_mmu label, it returns with an rfi and hangs.

This is exactly what I meet now.
If you have good solutions, please let me know.

Thank you very much.

machael


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
