From: Paul Mackerras <paulus@linuxcare.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <14669.33990.581970.248299@argo.linuxcare.com.au>
Date: Mon, 19 Jun 2000 12:26:14 +1000 (EST)
To: tom_gall@vnet.ibm.com
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.4.0-test1 linux/sched.h
In-Reply-To: <39478BE8.3B6E6157@vnet.ibm.com>
References: <39478BE8.3B6E6157@vnet.ibm.com>
Reply-To: paulus@linuxcare.com.au
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


tom_gall@vnet.ibm.com writes:

> Anyone notice that on
>
> 2.4.0-test1-ac18 that sched.h was changed to remove
>
> #define PF_PTRACED 0x00000010
> #define PF_TRACESYS 0x00000020

Yes, this was part of a fix for a race condition in accessing the
tsk->flags field.  Initially only ix86 was updated with the necessary
changes but I have since sent in a patch to Alan and it should be
fixed in the latest -ac version.

Paul.

--
Paul Mackerras, Senior Open Source Researcher, Linuxcare, Inc.
+61 2 6262 8990 tel, +61 2 6262 8991 fax
paulus@linuxcare.com.au, http://www.linuxcare.com.au/
Linuxcare.  Support for the revolution.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
