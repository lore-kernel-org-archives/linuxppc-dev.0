Message-ID: <3F0C7B57.1030509@paulidav.org>
Date: Wed, 09 Jul 2003 13:30:15 -0700
From: Vladimir Gurevich <vag@paulidav.org>
MIME-Version: 1.0
To: Kent Borg <kentborg@borg.org>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Heretical Question
References: <20030709155723.G20807@borg.org>
In-Reply-To: <20030709155723.G20807@borg.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello Kent,

I guess

        ddd --gdb --debugger ${CROSS_COMPILE}gdb <elf_file>

is what you are looking for.

With regards to assembly language debugging your mileage may
vary. While GDB supports assemblty language there seem to be
a couple of bugs which sometimes prevent you from doing it
(mostly when the code is being relocated). Wolfgang Denk
is working on it. And make sure you compile your assembly
code with -gstabs to enable line number information.

Thanks,
Vladimir


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
