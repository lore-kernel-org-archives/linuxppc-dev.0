Message-Id: <20010401003513.Postino-002933@smtp01.highway.ne.jp>
Date: Sun, 1 Apr 2001 00:35:13 +0900
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: <linuxppc-dev@lists.linuxppc.org>
From: Kaoru Fukui <k_fukui@highway.ne.jp>
Subject: Re: Fwd: CPU features
In-Reply-To: <20010331091615.3225@smtp.wanadoo.fr>
References: <20010331091615.3225@smtp.wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: <linuxppc-dev@lists.linuxppc.org>
Subject: Fwd: CPU features
Date: Sat, 31 Mar 2001 11:16:15 +0200

>
> I finally finished my cpu table & features stuff. It's in my rsync
> kernel at penguinppc::linux-2.4-benh. It may still need some fixes
> for 4xx/8xx and power3/4, so please, look at it and send me patches ;)
>

Please fix your typo in arch/ppc/kernel/feature.c
it's in void feature_core99_kick_cpu(int cpu_nr)


void
feature_core99_kick_cpu(int cpu_nr)
<snip>
     if (!keylargo_base || nr > 3 )    <-- cpu_nr ?


I guess, that nr is your typo.
Is it cpu_nr   ?

Please fix it where compile stop.


Thanks
Kaoru


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
