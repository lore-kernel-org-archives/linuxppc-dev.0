Return-Path: <glikely@secretlab.ca>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.227])
	by ozlabs.org (Postfix) with ESMTP id 020C3DDDF9
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  2 Nov 2007 14:01:12 +1100 (EST)
Received: by wr-out-0506.google.com with SMTP id 71so486419wri
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 01 Nov 2007 20:01:11 -0700 (PDT)
Message-ID: <fa686aa40711012001s194851f5y49e83214317edc41@mail.gmail.com>
Date: Thu, 1 Nov 2007 21:01:10 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Wang, Baojun" <wangbj@lzu.edu.cn>
Subject: Re: serial GDBServer PPC405 problems
In-Reply-To: <394030244.20640@eyou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
References: <393936343.10887@lzu.edu.cn> <394030244.20640@eyou.net>
Cc: khollan <khollan@daktronics.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 11/1/07, Wang, Baojun <wangbj@lzu.edu.cn> wrote:
> On Friday 02 November 2007 00:49:16, khollan wrote：
> > Hi everyone
> > I want to thank everyone for helping with all of my problems so far, you
> > have been a great help.
> >
> > Im trying to get a debug session with gdbserver over a serial connection on
> > my Xilinx ML410 using a uartlite set at Baud 115200.  When I issue the
> > command on the target "./gdbserver /dev/ttyUL1 test" I get this error:
> > Remote debugging using /dev/ttyUL1
> > readchar: Socet operation on non-socket
> > Remote Side has terminated connection.  GDBserver will reopen connection.
> >
> > This error just repeats until I kill the process.  I know that gdbserver
> > works because debugging over TCP works fine.
> > Thanks for your help
>
> Your kernel don't have kgdb support? then you need a debugger like bdi2000 to
> debug the kernel.

It sounds like he is trying to debug userspace.  Neither kgdb nor the
bdi2000 are the best tool for that.

Khollan; I haven't seen that problem before.  I don't know what could
be the issue there, but I'm not a gdbserver expert either.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
