From: Paul Mackerras <paulus@linuxcare.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <14735.40732.68586.256772@argo.linuxcare.com.au>
Date: Tue, 8 Aug 2000 15:48:12 +1000 (EST)
To: Tom Gall <gall@rochcivictheatre.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: request region in the wrong spot?
In-Reply-To: <398DD9BB.30521791@rochcivictheatre.org>
References: <398DD9BB.30521791@rochcivictheatre.org>
Reply-To: paulus@linuxcare.com.au
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Tom,

>   I propose moving this 6 request region calls to
>
>   arch/ppc/kernel/setup.c in ppc_init()
>
>   which is called by init/main do_basic_setup() fairly early.
>
>   Is this a reasonable fix?

I suggest you instead put the calls in chrp_init2 in chrp_setup.c.  I
have just about got 2.4.0-test6-pre6 working on the longtrail chrp
here, have a look at the linuxcare.com.au::linux-pmac-devel tree.

Paul.

--
Paul Mackerras, Senior Open Source Researcher, Linuxcare, Inc.
+61 2 6262 8990 tel, +61 2 6262 8991 fax
paulus@linuxcare.com.au, http://www.linuxcare.com.au/
Linuxcare.  Support for the revolution.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
