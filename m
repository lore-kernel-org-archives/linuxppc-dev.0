Message-Id: <20001228062746.Postino-011464@smtp01.highway.ne.jp>
Date: Thu, 28 Dec 2000 06:27:46 +0900
To: Benjamin Herrenschmidt <bh40@calva.net>
CC: <linuxppc-dev@lists.linuxppc.org>
From: Kaoru Fukui <k_fukui@highway.ne.jp>
Subject: Re: 2.4.0test13 + Dual G4
In-Reply-To: <19341121032716.6201@192.168.1.2>
References: <20001227041316.Postino-032677@smtp01.highway.ne.jp>
 <19341121032716.6201@192.168.1.2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


From: Benjamin Herrenschmidt <bh40@calva.net>
To: Kaoru Fukui <k_fukui@highway.ne.jp>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: 2.4.0test13 + Dual G4
Date: Wed, 27 Dec 2000 10:55:32 +0100

> >Yesterday linux_2_5`s source was broken for SMP.
> >SingleCPU kernel was very well.
> >
> >Now I'm puting kernel-2.4.0-test13pre3ac4 from linux_2_3.
>
> Be careful not to mismatch linux_2_3 and linuxppc_2_3. These are 2
> different trees on fsmlabs.com. (linux_2_3 is linus tree while
> linuxppc_2_3 is the PPC tree). It's possible that Paul's latest SMP fixes
> did not yet make it into _2_5.
>
> Ben.

Thanks Ben.

I'm struggling with bk tree 5000 linuxppc_2_3.

The source was able to run as singleCPU.
it's good working mono cpu.
The compilation is no problem,
 I set SMP flag ,then the compilation have done,
but the kernel say one cpu.

Kaoru


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
