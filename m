Return-Path: <chzigotzky@xenosoft.de>
Received: from mo6-p00-ob.smtp.rzone.de (mo6-p00-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5300::9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 57C221A0286
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Dec 2015 08:11:42 +1100 (AEDT)
Subject: [P.A. Semi] Does the ethernet interface work on your Electra, Chitra,
 Nemo, and Athena board?
To: Michael Ellerman <mpe@ellerman.id.au>, Gabriel Paubert <paubert@iram.es>,
 netdev@vger.kernel.org, Denis Kirjanov <kda@linux-powerpc.org>,
 linuxppc-dev@lists.ozlabs.org
References: <565AF986.9060106@xenosoft.de>
 <CAOJe8K1911vDjMe9m_1vY6DSGpOk0TmL96Qf1whuNFXxHJesGw@mail.gmail.com>
 <565C1B55.4020207@xenosoft.de> <565C8287.7090209@xenosoft.de>
 <20151130181217.GA15921@visitor2.iram.es> <565DB2FE.1010706@xenosoft.de>
 <565E7A9E.4000909@xenosoft.de> <1449044072.24750.3.camel@ellerman.id.au>
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Message-ID: <565F5E7C.9040207@xenosoft.de>
Date: Wed, 2 Dec 2015 22:11:24 +0100
MIME-Version: 1.0
In-Reply-To: <1449044072.24750.3.camel@ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Michael,

Thanks a lot for your answer. We tested some vanilla mainline 4.3 
kernels on an Electra reference board. Additionally we tested some 
patched 4.3 kernels on our Nemo boards.

It would be really fantastic, if you could fix the problem.

Cheers,

Christian

On 02 December 2015 at 09:14 AM, Michael Ellerman wrote:
> On Wed, 2015-12-02 at 05:59 +0100, Christian Zigotzky wrote:
>> Hi all,
>>
>> We tested some 4.3 kernels on a P.A. Semi reference board. Ultimately,
>> ethernet does not work, though on the reference board, the interface is
>> detected, gets link, but will not pass any packets/traffic.
>>
>> Somewhere in the source code of the commit "'powerpc-4.3-1' of
>> git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux (2015-09-03
>> 23:41:38 (GMT)" is the problem.
>>
>> Could you please help us to solve the problem?
> Hi Christian,
>
> Unfortunately there is no source code in that commit, it's just a merge. And
> your bisect run found that the very first commit in that merge was OK:
>
>>> [390fd5929f52bdfb9dfcc03820041ba556780f4a] cxl: Set up and enable PSL
>>> git bisect good
> So I'm not convinced your bisect run was correct, sorry.
>
> My pasemi is booting OK, but I haven't had time to test the network. If you
> remind me next week I will make sure network is working on my board.
>
> Are you testing your board with your additional patch as well? Or just vanilla
> mainline?
>
> cheers
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
