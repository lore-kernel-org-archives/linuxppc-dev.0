From: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
To: Gabriel Paubert <paubert@iram.es>
Subject: Re: Some issues to resolve with XFree 4.0 yet
Date: Wed, 29 Mar 2000 21:39:36 +0200
Content-Type: text/plain
Cc: David Edelsohn <dje@watson.ibm.com>,
        "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>,
        Ani Joshi <ajoshi@shell.unixbox.com>,
        Ryuichi Oikawa <roikawa@rr.iij4u.or.jp>,
        linuxppc-dev@lists.linuxppc.org
References: <Pine.HPX.4.10.10003291638170.6902-100000@gra-ux1.iram.es>
In-Reply-To: <Pine.HPX.4.10.10003291638170.6902-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Message-Id: <00032922002201.03866@enzo.bigblue.local>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Am Wed, 29 Mar 2000 schrieb Gabriel Paubert:
>On Wed, 29 Mar 2000, Franz Sirl wrote:
>
>> Hmm, I was thinking about adding __attribute__((little_endian)) and
>> __attribute__((big_endian)) to further describe variables. This should give
>> us optimum optimization on various platforms. Even things like:
>>
>> union {
>>          unsigned long little_var __attribute__((little_endian));
>>          unsigned long big_var __attribute__((big_endian));
>> }
>>
>> should be possible then.
>
>Indeed, but I was considering it as a later step. I have the feeling that
>adding a builtin would be simpler and would allow to build the necessary
>infrastructure for attribute support with minimal intermediate breakage
>(perhaps by implementing it only on some architectures at first).

Adding the attributes is quite simple, the part not quite clear to me yet is how
to evaluate the attribute in the backend and if we need middle-end support.
Evaluating the attribute directly in the backend mov* patterns seems
straightforward, but maybe separate reversed_mov* patterns maybe more
appropriate...

>Furthermore, the subject of adding this attribute has appeared on a quite
>regular basis on GCC mailing lists in the last few years and nothing has
>ever been done about it AFAICT. Perhaps a different strategy through
>builtin functions would get things started, that's why I'm suggesting it.

As always with GCC, if you want something done, do it yourself :-) (unless you
can pay somebody for coding).

Franz.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
