From: Paul Mackerras <paulus@linuxcare.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <14805.17492.766815.388301@argo.linuxcare.com.au>
Date: Sat, 30 Sep 2000 12:39:32 +1100 (EST)
To: frowand@mvista.com
Cc: Dan Malek <dan@mvista.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: __ioremap_at() in 2.4.0-test9-pre2
In-Reply-To: <39D4E85F.926CFD5B@mvista.com>
References: <19340822040932.8760@mailhost.mipsys.com>
	<Pine.LNX.4.10.10009281150130.3468-100000@cassiopeia.home>
	<14803.57550.118150.759977@argo.linuxcare.com.au>
	<39D41AA2.C586D738@mvista.com>
	<14804.7238.688771.238444@argo.linuxcare.com.au>
	<39D4E85F.926CFD5B@mvista.com>
Reply-To: paulus@linuxcare.com.au
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Frank Rowand writes:

> Paul Mackerras wrote:
[snip]
> > Because we'll make it the same value for all ports.  Anybody got any
> > objections to 0xff000000?

> Yes.  It is equivalently mapped on the PPC 405 at 0xe8000000.

But that's a physical address, not necessarily a virtual address,
right?  I was talking about virtual address 0xff000000.  Any
particular reason why you have to have virtual == physical?  (If there
is, my response will probably be "fix it". :-)

Paul.

--
Paul Mackerras, Senior Open Source Researcher, Linuxcare, Inc.
+61 2 6262 8990 tel, +61 2 6262 8991 fax
paulus@linuxcare.com.au, http://www.linuxcare.com.au/
Linuxcare.  Support for the revolution.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
