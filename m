Message-Id: <v03130305b4ef3818f765@[10.0.0.55]>
In-Reply-To: <002001bf8add$8b37aaf0$1dc9a4cd@rtdsp.com>
References: <Pine.HPX.4.10.10003071044220.22162-100000@gra-ux1.iram.es>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Fri, 10 Mar 2000 15:46:37 -0800
To: "Rob Grimm" <rgrimm@rtdsp.com>, <linuxppc-embedded@lists.linuxppc.org>
From: Gilbert Coville <gilbert@mvista.com>
Subject: Re: Cross-compiling Bash
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


At 2:11 PM -0800 3/10/00, Rob Grimm wrote:

>Does anyone have any suggestions?  I'm trying to avoid going out and buying
>a powermac.  How do others handle this problem, when developing code
>on a non-powerpc platform?

Cross compiling bash is pretty weird.

Check out how we did it in the 8xx version of our Cross Development Kit.
The recipe will be the same for your 750 -- just point it to your 750 cross
tools.  The recipe is in the %build portion of the SPEC file in the SRPM
for bash:
ftp://ftp.mvista.com/pub/CDK/1.0/ppc_8xx/SRPMS/hhl-ppc_8xx-bash-2.03-4.src.rpm

Also, we'll have a 750-based version of our CDK out in a few days, if
you're willing to wait.

Gilbert

--
Gilbert Coville			MontaVista Software Inc.
gilbert@mvista.com		+1 408-328-9208


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
