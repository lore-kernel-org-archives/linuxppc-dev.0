From: Paul Mackerras <paulus@linuxcare.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <14837.28240.588096.139146@argo.linuxcare.com.au>
Date: Tue, 24 Oct 2000 22:11:12 +1100 (EST)
To: Martin Costabel <costabel@wanadoo.fr>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.2.18-pre17 candidate
In-Reply-To: <39F552C8.91856B0C@wanadoo.fr>
References: <14837.11341.207379.903189@argo.linuxcare.com.au>
	<39F552C8.91856B0C@wanadoo.fr>
Reply-To: paulus@linuxcare.com.au
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Martin Costabel writes:

> First of all, you don't use CONFIG_MAGIC_SYSRQ, do you? If you do, you

Not usually, no.  How did you guess?  :-)

> Having fixed the corresponding 6 or 8 files, compilation went through to
> the end, but in the final "ld ... -o vmlinux", there were dozens of
> undefined symbols, like:

Could you send me a copy of your .config?

Thanks,
Paul.

--
Paul Mackerras, Senior Open Source Researcher, Linuxcare, Inc.
+61 2 6262 8990 tel, +61 2 6262 8991 fax
paulus@linuxcare.com.au, http://www.linuxcare.com.au/
Linuxcare.  Support for the revolution.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
