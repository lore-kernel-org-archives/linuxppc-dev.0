To: "Ing.Gianfranco Morandi" <gianfranco.morandi@euro-studio.it>
Cc: "LinuxPPC" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: 8260 MCC Interrupt priority 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 09 Sep 2002 18:47:08 +0200."
             <020c01c25820$89c23880$0700a8c0@pc005>
Date: Mon, 09 Sep 2002 21:36:56 +0200
Message-Id: <20020909193701.AABCDFA8B@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Gianfranco,

in message <020c01c25820$89c23880$0700a8c0@pc005> you wrote:
>
> I'm currently working on a custom board derived from EST8260. We are trying
> to implement a device driver of MCC to control the interface with a
> synchrounous PCM.
> I have noted that when there is an interrupt on SCC1 (or FCCx) the latency
> time of MCC interrupt increase. Now I'm really concerned about the
> possibility to loose some frame due to an heavy use of such interfaces.

If losing a frame is _that_ critical to you yoy should consider using
RTAI.

> Do anybody knows if there is the possibility to avoid such behaviour (maybe
> allowing an interrupt casting with the MCC ISR)?

With RTAI you can register the MCC as a real-time interrupt which has
higher priority than all Linux stuff, guaranteed.

See http://www.rtai.org/ , and feel free to contact me when you  need
help.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
The software required `Windows 95 or better', so I installed Linux.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
