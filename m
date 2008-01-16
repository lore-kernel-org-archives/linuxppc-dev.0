Return-Path: <joakim.tjernlund@transmode.se>
Received: from tmnt04.transmode.se (mail.transmode.se [83.241.175.147])
	by ozlabs.org (Postfix) with ESMTP id 9864ADDE2B
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 16 Jan 2008 11:35:01 +1100 (EST)
From: "Joakim Tjernlund" <joakim.tjernlund@transmode.se>
To: <rmcguire@videopresence.com>
References: <mailman.1.1200358805.3196.linuxppc-embedded@ozlabs.org>
	<000301c857b0$09f01a10$6405a8c0@absolut>
	<000001c857d5$6154b110$23fe1330$@tjernlund@transmode.se>
	<000301c857d7$0195f890$6405a8c0@absolut>
In-Reply-To: <000301c857d7$0195f890$6405a8c0@absolut>
Subject: Re: Driver - HDLC 83xx QUICC Engine??
Date: Wed, 16 Jan 2008 01:34:51 +0100
Message-ID: <000301c857d7$9c1eaba0$d45c02e0$@tjernlund@transmode.se>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> -----Ursprungligt meddelande-----
> Fr=E5n: Russell McGuire [mailto:rmcguire@videopresence.com]
> Skickat: den 16 januari 2008 01:31
> Till: 'Joakim Tjernlund'
> Kopia: linuxppc-embedded@ozlabs.org
> =C4mne: RE: Driver - HDLC 83xx QUICC Engine??
>=20
> Jocke,
>=20
> I'll let you know if I find any.  For a starting point, I have an QE =
ATM
> driver, that is more than likely similar in design <though no Ethernet
> interface>, as it supports the QE engine, and just turns the UCC into =
ATM
> mode, as opposed to HDLC mode. Would imagine the buffering, IO, =
interrupts
> are similar. I am still in process of porting it up from the 82xx CPU.
>=20
> Although HDLC how it registers itself into the kernel is a mystery to =
me, I
> am having trouble finding any HDLC drivers to model this after.  Know =
of any
> specs? API? Etc...

Sorry but I don't know. Luckily for me I don't have too either.

 Jocke
