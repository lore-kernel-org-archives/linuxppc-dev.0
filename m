Message-ID: <001901c3f784$72edb2b0$0400a8c0@portatile>
Reply-To: "Ing.Gianfranco Morandi (LAN)" <gianfranco.morandi@euro-studio.it>
From: "Ing.Gianfranco Morandi (LAN)" <gianfranco.morandi@euro-studio.it>
To: <linuxppc-embedded@lists.linuxppc.org>,
	"Karsten Jeppesen" <kj-list@jeppesens.com>
References: <321DD189-631A-11D8-B915-000393D57FEE@jeppesens.com>
Subject: Re: Simple module question
Date: Fri, 20 Feb 2004 08:37:51 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Look at the "Linux Device Driver" By A.Rubini & J.Corbett, there are a lot
of suggestions and examples.

Gianfranco

---- Original Message -----
From: "Karsten Jeppesen" <kj-list@jeppesens.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Sent: Thursday, February 19, 2004 9:28 PM
Subject: Simple module question


>
> Aren't they all......
>
>
> I am doing some heavy work in a write function.
> But I have a poll wait loop (waiting for flash program end) where a lot
> of time is wasted.
> How do I tell the scheduler that I would like t surrender the CPU for
> others to use?
> I tried calling scheduler(), but that only crashed the kernel.
> What is the correct way?
>
> Sincerely,
> Karsten
>
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
