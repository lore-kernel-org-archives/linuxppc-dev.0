In-Reply-To: <38870F4A.44918575@global2000.net>
Date: Thu, 20 Jan 2000 16:42:44 +0100
To: "Andrew B. Arthur" <arthur99@global2000.net>,
        linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: BootX slowdown
Message-Id: <20000120164244.018605@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Jan 20, 2000, Andrew B. Arthur <arthur99@global2000.net> wrote:

>>
>>  - boot with BootX 1.2b3 in the exact same configuration that usually
>> triggers the slowdown problem. You may eventually boot single user or
>> even "init=/bin/sh" so that it doesn't take for ever to reach bash prompt.
>
>Running on a PowerMacintosh 4400/200. BootX 1.2b3 and BootX 1.1.3
>results listed below. Linux hagoleche.aarthur.bsdonline.org 2.2.14 #1
>Sun Jan 16 02:39:35 EST 2000 ppc unknown

It appears that on some machines, the ICTC is not 0 when booting from
MacOS. I'll add code to reset it in a next kernel. This may or may not be
the cause of your problem (this issue was spotted on a G3-based powerbook).


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
