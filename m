Date: Mon, 09 Sep 2002 20:00:33 -0400
From: Dan Brennan <dmb8@optonline.net>
Subject: Re: 8260 MCC Interrupt priority
To: "Ing.Gianfranco Morandi" <gianfranco.morandi@euro-studio.it>
Cc: LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Message-id: <3D7D3621.5C62AC56@optonline.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
References: <020c01c25820$89c23880$0700a8c0@pc005>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Which silicon version are you using, e.g., B.3? Read the errata for the
part. Activity on FCC1 can wreak havoc on a very busy MCC.

"Ing.Gianfranco Morandi" wrote:
>
> Hi to everybody,
>
> I'm currently working on a custom board derived from EST8260. We are trying
> to implement a device driver of MCC to control the interface with a
> synchrounous PCM.
> I have noted that when there is an interrupt on SCC1 (or FCCx) the latency
> time of MCC interrupt increase. Now I'm really concerned about the
> possibility to loose some frame due to an heavy use of such interfaces.
>
> Do anybody knows if there is the possibility to avoid such behaviour (maybe
> allowing an interrupt casting with the MCC ISR)?
>
> Many thanks
>
> Gianfranco Morandi
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
