Date: Tue, 10 Jul 2001 14:21:13 +0200
From: Olaf Hering <olh@suse.de>
To: Kaoru Fukui <k_fukui@highway.ne.jp>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Kernel-2.4.7.pre5
Message-ID: <20010710142113.B21458@suse.de>
References: <20010710210004.Postino-030256@smtp01.highway.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20010710210004.Postino-030256@smtp01.highway.ne.jp>; from k_fukui@highway.ne.jp on Tue, Jul 10, 2001 at 09:00:04PM +0900
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Jul 10, Kaoru Fukui wrote:

>
> Hi!
>
> I had this problem in linuxppc_2_4 bk tree's linux-2.4.7.pre5.
> Is my fix correct ?

The "correct" fix would be somthing like that:
/mirror/kernel/people/andrea/kernels/v2.4/2.4.7pre3aa1/00_ksoftirqd-7_ppc-2

But Paul was/is not very happy about that softirq thing...



Gruss Olaf

--
 $ man clone

BUGS
       Main feature not yet implemented...

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
