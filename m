From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15365.22636.100149.747039@gargle.gargle.HOWL>
Date: Thu, 29 Nov 2001 08:34:36 +1100 (EST)
To: Adrian Cox <adrian@humboldt.co.uk>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: include/asm-ppc/platforms/
In-Reply-To: <3C04A483.6070206@humboldt.co.uk>
References: <15363.31192.101536.919771@gargle.gargle.HOWL>
	<3C2B376F.9070508@embeddededge.com>
	<15364.32906.728532.676746@gargle.gargle.HOWL>
	<3C04A483.6070206@humboldt.co.uk>
Reply-To: paulus@samba.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Adrian Cox writes:

> All my boards now use early_serial_setup() instead of a platform header
> file. This approach is simple to write, and requires no modifications
> outside the platform_setup.c file. I'd rather not go back to providing
> platform specific serial definitions in a header file.

Perfectly reasonable - I wish all the platforms used early_serial_setup.
Would you mind posting your code that does the early_serial_setup calls?

Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
