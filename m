Mime-Version: 1.0
Message-Id: <v04220802b4c015dac1c7@[10.0.0.42]>
In-Reply-To: <38993D7F.B0964A77@dalim.de>
References: 
 <88732CD95EB64875C125687900681C6E.00681C98C1256879@kehl.dalim.de>
 <38993D7F.B0964A77@dalim.de>
Date: Thu, 3 Feb 2000 22:19:34 -0800
To: Stephane GEORGES <sg@dalim.de>
From: "Timothy A. Seufert" <tas@mindspring.com>
Subject: Re: Speed tests - G4-400 and PIII-600
Cc: linuxppc-dev@lists.linuxppc.org
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 9:34 AM +0100 2/3/00, Stephane GEORGES wrote:
>I've made speed tests on programs running on my LinuxPPC on G4-400 Mhz AGP,
>and on Pentium III 600 Mhz.

>Bogomips:
>     - on Intel : ~ 600
>     - on PowerPC: ~ 800

BogoMIPS is meaningless.  It is not a benchmark.

>The test programs are dealing with run-length images processing.
>
>I was disapointed by the fact that the Intel machine ran 25% faster
>than the PowerPC machine.
>
>I thought that a G4-400 was worth a PIII-800 ...

That's just marketing hype.

>Maybe gcc including Alvitec patches will provide better performances ...

Perhaps.  But you'd have to recode your software to use AltiVec; you
can't just recompile and get a speed boost.  And you'd have to do the
same with the PIII SSE vector instructions to make a fair comparison.
AltiVec is better overall than SSE, but how much better depends a lot
on the application.

Actually, I'd say that the G4 put in a pretty good show, considering
that the PIII's clock rate is 50% faster.  Last time I looked, the G4
and PIII have about the same SPECint95 rating at the same clock
speed, though the G4 is considerably better at SPECfp95.

Motorola's inability to ramp up G4 clock speeds is a big problem.

   Tim Seufert

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
