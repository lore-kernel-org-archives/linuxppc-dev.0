Date: Tue, 1 Jun 2004 14:18:47 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: David Ho <DavidHo@nanometrics.ca>
Cc: linuxppc <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: no core dump from the kernel on SIGSEGV
Message-ID: <20040601211846.GB17412@gate.ebshome.net>
References: <20040601173804.04313C109F@atlas.denx.de> <OF256E275C.8F4C3907-ON85256EA6.006EE439-85256EA6.006FEE36@nanometrics.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <OF256E275C.8F4C3907-ON85256EA6.006EE439-85256EA6.006FEE36@nanometrics.ca>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Jun 01, 2004 at 04:22:34PM -0400, David Ho wrote:
>
> Hi all,
>
> I'm looking at making the kernel core dump on a process that seg vaulted.
> What I did was recompiled the kernel specifying a non-zero core file size
> rlim[RLIMIT_CORE] = { RLIM_INFINITY, RLIM_INFINITY }.  I was still not
> getting a core dump.
>

DO NOT TOUCH the kernel!

Please, read about ulimit shell command.

Eugene


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
