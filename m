From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kaoru Fukui <k_fukui@highway.ne.jp>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: Fwd: CPU features
Date: Sat, 31 Mar 2001 19:14:33 +0200
Message-Id: <20010331171433.11295@smtp.wanadoo.fr>
In-Reply-To: <20010401003513.Postino-002933@smtp01.highway.ne.jp>
References: <20010401003513.Postino-002933@smtp01.highway.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>
>Please fix your typo in arch/ppc/kernel/feature.c
>it's in void feature_core99_kick_cpu(int cpu_nr)
>
>
>void
>feature_core99_kick_cpu(int cpu_nr)
><snip>
>     if (!keylargo_base || nr > 3 )    <-- cpu_nr ?
>
>
>I guess, that nr is your typo.
>Is it cpu_nr   ?
>
>Please fix it where compile stop.

Right, I didn't test it on SMP yet. I've pushed that fix to my
devel tree along with a few other stuffs & updated to 2.4.3.
The rsync should be up-to-date in a few minutes.

Please tell me if the dual G4 kicks properly the other CPU as
I changed the way it's done but didn't have a chance to test my
new code yet.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
