From: Paul Mackerras <paulus@linuxcare.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <14807.49063.358772.190447@argo.linuxcare.com.au>
Date: Mon, 2 Oct 2000 09:50:15 +1100 (EST)
To: Dan Malek <dan@mvista.com>
Cc: frowand@mvista.com,
        Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: __ioremap_at() in 2.4.0-test9-pre2
In-Reply-To: <39D7ACEC.D8E572DE@mvista.com>
References: <19340822040932.8760@mailhost.mipsys.com>
	<Pine.LNX.4.10.10009281150130.3468-100000@cassiopeia.home>
	<14803.57550.118150.759977@argo.linuxcare.com.au>
	<39D41AA2.C586D738@mvista.com>
	<14804.7238.688771.238444@argo.linuxcare.com.au>
	<39D4E85F.926CFD5B@mvista.com>
	<14805.17492.766815.388301@argo.linuxcare.com.au>
	<39D66E4D.4364FC8B@mvista.com>
	<39D68EB8.4CAD5168@mvista.com>
	<14806.62164.27906.255635@argo.linuxcare.com.au>
	<39D7ACEC.D8E572DE@mvista.com>
Reply-To: paulus@linuxcare.com.au
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Dan Malek writes:

> Yes, and I do that.  The problem is many of the embedded boards map
> stuff
> above 0xff000000 (or 0xf0000000), which overlaps your "standard" PowerPC
> in/out mapping.

Now, are those addresses physical or virtual?

My point is that we can do what we like with the virtual address
assignments.  If you are saying "but we have device registers at
physical address 0xff000000" my response is "so why is that a
problem?".

Paul.

--
Paul Mackerras, Senior Open Source Researcher, Linuxcare, Inc.
+61 2 6262 8990 tel, +61 2 6262 8991 fax
paulus@linuxcare.com.au, http://www.linuxcare.com.au/
Linuxcare.  Support for the revolution.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
