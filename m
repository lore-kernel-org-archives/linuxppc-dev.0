Date: Fri, 6 Jun 2003 19:05:35 +0200
From: Magnus Damm <damm@opensource.se>
To: brian.auld@adic.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: x86(host) --> ppc(tgt) cross-tool-chain
Message-Id: <20030606190535.644a4939.damm@opensource.se>
In-Reply-To: <995FF289C9D69747A09E4299264459540C109867@penguin.adic.com>
References: <995FF289C9D69747A09E4299264459540C109867@penguin.adic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I don't know about that book and your specific glibc version,
but earlier versions of glibc (2.1.3) needed a patch to correctly
support powerpc processors with 16-byte cachelines like the 4xx- and
8xx-series.

I've built several cross compilers (for ppc) from scratch for use on
x86-based machines using gcc-2.95.3 and glibc-2.1.3. I have tested
several binutils versions, don't remember all right now, but I think
binutils-2.11.2 worked out ok except for some strip command line problems.

And yes, the toolchain was used with mpc8xx processors.

/ magnus

On Fri, 6 Jun 2003 07:11:39 -0700
brian.auld@adic.com wrote:

>
> Hello,
>
> Using Karim's new book "Building Embedded Linux Systems", has anyone out there successfully built an x86(host) --> ppc(tgt) tool chain using the versions stipulated in the book (gcc 2.95.3, binutils: 2.10.1, glibc, 2.2.1).
>
> If yes:
>
> (a) What host system are you using?
>
> (b) Did you diverge from the directions in the book?
>
> If no:
>
> (a) Can someone out there suggest a known valid combination?
>
>
> I anticipate needing ssh, some web-server and snmp as application requirements, so I figured it would be prudent to get the tool-chain working with glibc as opposed to uClibc.
>
> -- Brian
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
