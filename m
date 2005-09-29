Return-Path: <ananthakiran@gmail.com>
Received: from xproxy.gmail.com (xproxy.gmail.com [66.249.82.201])
	by ozlabs.org (Postfix) with ESMTP id 3313F68336
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Sep 2005 15:25:59 +1000 (EST)
Received: by xproxy.gmail.com with SMTP id s16so1295484wxc
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Sep 2005 22:25:58 -0700 (PDT)
Message-ID: <dc204d3f0509282219580befb3@mail.gmail.com>
Date: Thu, 29 Sep 2005 10:49:16 +0530
From: Anantha Kiran Kandukuri <ananthakiran@gmail.com>
To: linuxppc-dev@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_1152_21834323.1127971156216"
Subject: Determining physical processors on SMT driven architectures
Reply-To: Anantha Kiran Kandukuri <ananthakiran@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------=_Part_1152_21834323.1127971156216
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,
Is there a programatical way of caliculating physical CPUs on IBM
SMT driven archtitural machines.

I am aware of commands of sort "lsdev -C -c processor" and "smtctl".
But is there any API to do same thing. I saw "processor_info"
strucutre in "/usr/include/sys/iplcb.h" contains information i am
looking for. Is there a way to access this.

Linux on IntelHT, stores this info in "/proc/cpuinfo" file. Similarly
AIX stores this info in "/dev/pmem" file. In KDB, "ipl" subcommand
actually parses file "/dev/pmem" to access "processor_info" strctures.
Can i simulate these KDB commands in a programatical fashion.

Atleast, are there "CPUID" sort of assembly instructions in AIX, so
that i can probe for actual number of CPUs.

Any help is appreciated.

Thanks
-Ananth
--

------=_Part_1152_21834323.1127971156216
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,<br>
&nbsp;Is there a programatical way of caliculating physical CPUs on=20
IBM<br>
SMT driven archtitural machines.<br>
<br>
&nbsp;I am aware of commands of sort=20
&quot;lsdev -C -c processor&quot; and &quot;smtctl&quot;.<br>
But is there any API to do same thing.=20
I saw &quot;processor_info&quot;<br>
strucutre in &quot;/usr/include/sys/iplcb.h&quot; contains=20
information i am<br>
looking for. Is there a way to access this.<br>
<br>
&nbsp;Linux on=20
IntelHT, stores this info in &quot;/proc/cpuinfo&quot; file. Similarly<br>
AIX stores this=20
info in &quot;/dev/pmem&quot; file. In KDB, &quot;ipl&quot; subcommand<br>
actually parses file=20
&quot;/dev/pmem&quot; to access &quot;processor_info&quot; strctures.<br>
Can i simulate these KDB=20
commands in a programatical fashion.<br>
<br>
&nbsp;Atleast, are there &quot;CPUID&quot; sort of=20
assembly instructions in AIX, so<br>
that i can probe for actual number of=20
CPUs.<br>
<br>
&nbsp;Any help is appreciated.<br>
<br>
Thanks<br>
-Ananth<br>
--<br>

------=_Part_1152_21834323.1127971156216--
