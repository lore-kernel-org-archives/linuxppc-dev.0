Message-ID: <CA78D1B723D8D411AF0300508BDCF74F3F6D1C@NTCORREO>
From: IGOR LURI <iluri@fagorautomation.es>
To: =?ISO-8859-1?Q?EMBEDDED_LINUXPPC_=28Correo_electr=F3nico=29?= <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Minilibc works better than Library Optimizer
Date: Fri, 19 Apr 2002 08:13:12 +0200
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Kurt,

I have rebuild libc library to run busybox  and the result is a libc of  595
k. For a simple aplication like  Hello World the result is a libc of 477 k.
The libc without optimization it has 1.2 M.

	-----Mensaje original-----
	De:	Kurt Wall [SMTP:kurt.wall@timesys.com]
	Enviado el:	jueves, 18 de abril de 2002 20:27
	Para:	IGOR LURI
	Asunto:	Re: Minilibc works better than Library Optimizer

	An unnamed source, IGOR LURI, told us:
	>
	> Hi all,
	> I have waste a lot of time with Library Optimizer and I dont have
succes
	> with it. The glibc optimized with this tool doesn't work to me.
However, I
	> have found another tool named MINILIBC that works fine. This tool
can be
	> downloaded from
	>
	>
http://oss.software.ibm.com/developer/opensource/linux/projects/minilibc/rel
	> eases/
	>
	>  I have proobed with glibc-2.2.3 and works fine, I recomend to use
this tool
	> instead of library optimizer.

	What were the results? What were the savings?

	Kurt
	--
	Future looks spotty.  You will spill soup in late evening.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
