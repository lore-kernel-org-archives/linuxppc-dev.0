Message-ID: <000a01bff9b0$fab528c0$4c388aa4@crusman>
Reply-To: "Crusman" <Lionel.TAILLURAT@wanadoo.fr>
From: "Crusman" <Lionel.TAILLURAT@wanadoo.fr>
To: "Gabriel Paubert" <paubert@iram.es>,
        "Lionel TAILLURAT" <Lionel.TAILLURAT@ecrin.com>
Cc: "ppc_mailing_list" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: -= MVME 2300 boot args=-
Date: Sun, 30 Jul 2000 01:01:49 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I resolve the problem with the following Haddrive map :

sda2:  Prep boot partition starting at the first sector of the harddrive.
sda1:  root partition.
sda3:  swap partition.

and all work well.


Regards

Lionel.

-----Message d'origine-----
De : Gabriel Paubert <paubert@iram.es>
À : Lionel TAILLURAT <Lionel.TAILLURAT@ecrin.com>
Cc : ppc_mailing_list <linuxppc-embedded@lists.linuxppc.org>
Date : samedi 29 juillet 2000 19:08
Objet : Re: -= MVME 2300 boot args=-


>
>On Wed, 26 Jul 2000, Lionel TAILLURAT wrote:
>
>>
>> Hi,
>>
>> I have a full working kernel with VME bus support (thx Gabriel for your
>> patch and your help).
>>
>> The problem now is that I can't have the boot args working !
>>
>> During the configuration of the kernel, I write "root=/dev/sda2
>> console=ttyS0" in the "initial kernel command string" , and only
>> "console=ttyS0" is shown at boot prompt and the kernel don't see my
>> haddrive!
>>
>> If I use the command (in PPCBUG):
>> GEVEDIT bootargs
>> bootargs=root=/dev/sda2 console=ttyS0
>
>Prepboot still ha to be upgraded to take the arguments from the NVRAM. If
>you wnat to give it a try, it's not that complex,  just that I never fond
>the time to do it. It also still ignores the config option. Sorry...
>
>Nevertheless for the root device option, the right way to do it would be
>to use the same scheme as the Intel port. You can type make zImage
>ROOTDEV=/dev/sda2 for example. By default, it will automagically (on
>Intel pc) take the current root device which is very convenient.
>
>> Whats wrong ?
>
>My code :-(
>
> Regards,
> Gabriel.
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
