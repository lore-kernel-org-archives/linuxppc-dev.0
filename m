Message-Id: <200203151349.OAA21194@scully.gams.co.at>
To: "David Marqvar (DAM)" <DAM@tt.dk>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Transfer files via terminal (Zmodem) 
In-reply-to: Your message of "Thu, 14 Mar 2002 14:09:47 +0100."
             <E8F83D6D2A6AD3118E0300902786A2050237142D@NTEX>
Reply-To: mike@gams.at
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 15 Mar 2002 14:49:37 +0100
From: Mike Neuhauser <mike@gams.at>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <E8F83D6D2A6AD3118E0300902786A2050237142D@NTEX>, "David Marqvar (DAM
)" writes:

> > > Has anyone compiled sz/rz for ppc (MPC823) in order to use ZModem to
> > > transfer files via terminal connection to the target?
> > > Or, is the some other way of transferring files to my embedded system.
> > > I'm connected to it using a terminal (minicom, kermit). No network.
> > ppcboot supports kermit.
> > most of us just use srecords over a plain ascii connection.
>
> I want to do it directly within Linux after boot.
> (I'm currently running Busybox).
> I'm looking for a small Linux-util to reviece files from the serial line.

Try http://www.ohse.de/uwe/software/lrzsz.html, it's GPL, it works for me
(together with minicom).

Regards,
Mike

--
Dr. Michael Neuhauser             Phone: +43(1)205-255/201
maxxio technologies               Fax:   +43(1)205-255/900
Prinz Eugen-Strasse 8             Email: michael.neuhauser@maxxio.com
A-1040 Vienna/Austria/Europe


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
