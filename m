From: Paul Mackerras <paulus@linuxcare.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <14774.59123.968142.533410@argo.linuxcare.com.au>
Date: Thu, 7 Sep 2000 11:53:07 +1100 (EST)
To: "Rolf Liu" <rolfl@sc23.sc.mcel.mot.com>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: Re: question about 'r2' !!!
In-Reply-To: <00b401c017a9$91f50640$bf0102c8@sc.mcel.mot.com>
References: <00b401c017a9$91f50640$bf0102c8@sc.mcel.mot.com>
Reply-To: paulus@linuxcare.com.au
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Rolf Liu writes:

> I am currently engaged in compiling Linux-ppc source tree using a CC other
> than GCC.

This is going to be fraught with difficulty.  The Linux kernel source
uses quite a lot of the extensions to the C language which gcc
provides.  Basically the kernel is not designed to be compiled by
anything other than gcc.

--
Paul Mackerras, Senior Open Source Researcher, Linuxcare, Inc.
+61 2 6262 8990 tel, +61 2 6262 8991 fax
paulus@linuxcare.com.au, http://www.linuxcare.com.au/
Linuxcare.  Support for the revolution.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
