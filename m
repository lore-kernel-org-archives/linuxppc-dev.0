To: linuxppc-dev@lists.linuxppc.org
Subject: Re: is gcc optimized for g4 processors ?
References: <8EC5DD61D2E46E3CC125687900528BB1.00528C13C1256879@kehl.dalim.de>
	<389862CD.5E291FB7@dalim.de>
From: Holger Bettag <hobold@Informatik.Uni-Bremen.DE>
Date: 02 Feb 2000 18:33:45 +0100
In-Reply-To: Stephane GEORGES's message of Wed, 02 Feb 2000 18:01:02 +0100
Message-ID: <8xpuuf33wm.fsf@s62.informatik.uni-bremen.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Stephane GEORGES <sg@dalim.de> writes:

>
>
> I'm doing performance tests on my G4 - 400 AGP.
> I would like to know if gcc (egcs-2.91.66) can be optimized for G4 processor.
>
> Does -mcpu=7400 exists ?
>
I don't think the option is in there yet. But -mcpu=604e should fit the 7400
quite well, for both integer and floating point code. The only big scheduling
difference would be for integer multiplications.

(The 604e has a separate, pipelined integer multiplier, while the 7400's is
non-pipelined and blocks one of the integer units, but has an early-exit-
capability if one the factors has less than 32 significant bits.)

  Holger


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
