Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <000701c258eb$9092e4e0$0700a8c0@pc005>
Reply-To: "Ing.Gianfranco Morandi" <gianfranco.morandi@euro-studio.it>
From: "Ing.Gianfranco Morandi" <gianfranco.morandi@euro-studio.it>
To: "Wolfgang Denk" <wd@denx.de>
Cc: "LinuxPPC" <linuxppc-embedded@lists.linuxppc.org>
References: <20020909193701.AABCDFA8B@denx.denx.de>
Subject: Re: 8260 MCC Interrupt priority 
Date: Tue, 10 Sep 2002 19:00:27 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Many thanks for your suggestion, I have checked the references You gave me
and I believe that RTAI would be a good solution to solve our problem.
Actually I'm working with a quite old version of HardHat package (CDK 1.2
with 2.4.0-test2 kernel) with some minor patches in order to have the
ethernet 100% functionality, do You think we can easily port the RTAI on
this version or shall we migrate to HardHat 2.0?

Gianfranco

----- Original Message -----
From: "Wolfgang Denk" <wd@denx.de>
To: "Ing.Gianfranco Morandi" <gianfranco.morandi@euro-studio.it>
Cc: "LinuxPPC" <linuxppc-embedded@lists.linuxppc.org>
Sent: Monday, September 09, 2002 9:36 PM
Subject: Re: 8260 MCC Interrupt priority


> Dear Gianfranco,
>
> in message <020c01c25820$89c23880$0700a8c0@pc005> you wrote:
> >
> > I'm currently working on a custom board derived from EST8260. We are
trying
> > to implement a device driver of MCC to control the interface with a
> > synchrounous PCM.
> > I have noted that when there is an interrupt on SCC1 (or FCCx) the
latency
> > time of MCC interrupt increase. Now I'm really concerned about the
> > possibility to loose some frame due to an heavy use of such interfaces.
>
> If losing a frame is _that_ critical to you yoy should consider using
> RTAI.
>
> > Do anybody knows if there is the possibility to avoid such behaviour
(maybe
> > allowing an interrupt casting with the MCC ISR)?
>
> With RTAI you can register the MCC as a real-time interrupt which has
> higher priority than all Linux stuff, guaranteed.
>
> See http://www.rtai.org/ , and feel free to contact me when you  need
> help.
>
> Wolfgang Denk
>
> --
> Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
> Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
> The software required `Windows 95 or better', so I installed Linux.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
