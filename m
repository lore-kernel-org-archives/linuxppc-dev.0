Message-ID: <40E00899.2050906@ru.mvista.com>
Date: Mon, 28 Jun 2004 16:01:29 +0400
From: Yuri Frolov <yfrolov@ru.mvista.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: Unsuccessfull system call interception. Please, help to correct
 it or make a suggestion.
References: <40DC1669.5060808@dev.rtsoft.ru> <16604.50307.901331.251674@cargo.ozlabs.ibm.com>
In-Reply-To: <16604.50307.901331.251674@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Paul Mackerras wrote:

>Yuri Frolov writes:
>
>
>
>>The problem: due to the necessity of logging system calls entry/exit
>>events by LTT the arch/ppc/kernel/entry.S was modified in this way:
>>
>>
>
>First, you don't say whether you are working on 2.4 or 2.6.
>
>Secondly, why can't you use the existing syscall trace infrastructure?
>
>Paul.
>
>
>
>
>
I'm working on linux-2.6.
I can't use the existing syscall trace infrastructure due to the
necessity to get LTT syscall interception mechanism working (LTT has
specific routines and binary format it uses to save info about syscall
entry/exit, I can't just get rid of it).
I would be happy to address this problem someone who subscribed to the
LTT mailing list, but seems the development of LTT tends to be more x86
centric. I posted the message because my strong opinion that the problem
is in the interaction between common ppc syscall handling mechanism and
the LTT portion which both written on pure ppc assembly...


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
