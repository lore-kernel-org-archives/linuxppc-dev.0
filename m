Subject: Re: 4way smp on ppc32
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: ERIC NORTHUP <eric.northup@jhu.edu>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <7eb2247ee728.7ee7287eb224@jhumail.jhu.edu>
References: <7eb2247ee728.7ee7287eb224@jhumail.jhu.edu>
Content-Type: text/plain
Message-Id: <1080720349.1435.11.camel@gaston>
Mime-Version: 1.0
Date: Wed, 31 Mar 2004 18:05:50 +1000
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 2004-03-31 at 11:57, ERIC NORTHUP wrote:
> Hi all,
>
> I have been trying to get my 4-processor Daystar GenesisMP system to run Linux in smp mode,
> without success.  The system works reliably with a uniprocessor kernel.
> But it oopses on boot with an smp kernel.  I have attached a boot log from a
> serial console for a 2.6 kernel, but I get similar messages  with other
> kernels I've tried.  Although the log is from 2.6.4, I've tried 2.6.5-pre3 which
> included some ppc32 fixes, though they didn't fix this problem.
> I've also tried different gcc versions.
>
> I don't understand why only 2 of the 4 cpus would respond to the smp_call_function().
> Any suggestions for where to start looking?  I am not subscribed to linuxppc-dev,
> so please CC me on replies.  Thanks,

Interesting... Apparently, all the CPUs are coming in, but interrupts
don't get properly delivered to the "other" CPUs...

I'll have a look, that setup should work. Did you try a 2.4 kernel ?

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
