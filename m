Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
From: Jim Thompson <jim@musenki.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15504.40144.808774.825885@gargle.gargle.HOWL>
Date: Thu, 14 Mar 2002 06:51:28 -0600
To: "David Marqvar (DAM)" <DAM@tt.dk>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Transfer files via terminal (Zmodem)
In-Reply-To: <E8F83D6D2A6AD3118E0300902786A2050237142C@NTEX>
References: <E8F83D6D2A6AD3118E0300902786A2050237142C@NTEX>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


David Marqvar (DAM) writes:
>
> > Has anyone compiled sz/rz for ppc (MPC823) in order to use ZModem to
> > transfer files via terminal connection to the target?
> >
> > Or, is the some other way of transferring files to my embedded system. I'm
> > connected to it using a terminal (minicom, kermit). No network.

ppcboot supports kermit.

most of us just use srecords over a plain ascii connection.

--
These people program the way Victorians dress.  It takes two hours and
three assistants to put on your clothes, and you have to change before
dinner.  But everything is modular.   -- Miles Nordin


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
