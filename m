Subject: Re: Error in compiling 2.4.18 kernel for PPC
From: "Omanakuttan" <omanakuttan@tataelxsi.co.in>
To: gopi@india.tejasnetworks.com
Cc: linuxppc-embedded@lists.linuxppc.org,
	anil@india.tejasnetworks.com
In-Reply-To: 
	<Pine.LNX.4.21.0304290542560.27871-100000@localhost.localdomain>
References: <Pine.LNX.4.21.0304290542560.27871-100000@localhost.localdomain>
Content-Type: text/plain
Date: 29 Apr 2003 15:50:54 +0530
Message-Id: <1051611654.9742.16.camel@omyx>
Mime-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Seems like you did not do an mrproper before starting cross compilation.
try that.

On Tue, 2003-04-29 at 11:22, gopi@india.tejasnetworks.com wrote:
>
>   We are trying to compile kernel 2.4.18 for ppc(&mbxboard) with
> gcc(cross compiler version 2.95.2)
>
> Compilation breaks with the following error.
> -----------------------------------------------
> In file included from /opt/hardhat/devkit/ppc/8xx/lib/gcc-lib/powerpc-hardhat-linux/2.95.2/../../../../powerpc-hardhat-linux/include/linux/mm.h:4,
>                  from /opt/hardhat/devkit/ppc/8xx/lib/gcc-lib/powerpc-hardhat-linux/2.95.2/../../../../powerpc-hardhat-linux/include/asm/pgtable.h:7,


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
