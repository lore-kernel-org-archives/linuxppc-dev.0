In-Reply-To: <Pine.LNX.4.56.0311241732200.2581@mag.devdep.sysgo.de>
References: <3FC0A1D3.70706@imc-berlin.de> <B82FB2A3-1E4E-11D8-A8D4-003065E2BB06@aimsys.nl> <Pine.LNX.4.56.0311241732200.2581@mag.devdep.sysgo.de>
Mime-Version: 1.0 (Apple Message framework v606)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <45C0A1DA-1ECE-11D8-B460-003065E2BB06@aimsys.nl>
Cc: Steven Scholz <steven.scholz@imc-berlin.de>,
	"linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
From: Jaap-Jan Boor <jjboor@aimsys.nl>
Subject: Re: Preemptive Kernel and MPC8xx ???
Date: Mon, 24 Nov 2003 23:33:48 +0100
To: Marius Groeger <mgroeger@sysgo.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On 24-nov-03, at 17:35, Marius Groeger wrote:

>
> On Mon, 24 Nov 2003, Jaap-Jan Boor wrote:
>
>> Yes I do on 2.4.20 and 2.4.22 from kernel.org. So far all seems
>> to work but didn't do any measurements on it.
>> (I both use the preempt and low-latency patches)
>
> AFAIK, you can pretty much drop the low-latency patch in favor of
> using the lock-breaking patch. It is also available from Robert Love
> at the cited home page.

Yes, thanks, I know.
Is it better? I thought both low-latency and lock-break
do more or less the same.

Jaap-Jan


>
> Marius
>
> --
> Marius Groeger <mgroeger@sysgo.de>
> Project Manager
>
> SYSGO Real-Time Solutions AG | Embedded and Real-Time Software
> Am Pfaffenstein 14
> 55270 Klein-Winternheim, Germany
>
> Voice: +49-6136-9948-0 | FAX: +49-6136-9948-10
> www.sysgo.de | www.elinos.com | www.osek.de
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
