From: Paul Mackerras <paulus@linuxcare.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <14838.26913.598838.425732@argo.linuxcare.com.au>
Date: Wed, 25 Oct 2000 16:01:21 +1100 (EST)
To: Olaf Hering <olh@suse.de>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.2.18-pre17 candidate
In-Reply-To: <20001024221817.A24315@suse.de>
References: <14837.11341.207379.903189@argo.linuxcare.com.au>
	<20001024221817.A24315@suse.de>
Reply-To: paulus@linuxcare.com.au
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Olaf Hering writes:

> Is there a way to not compile the pmac_*.c stuff when pmac is not
> defined? At least for 2.2?

Sure, we now have a CONFIG_POWERMAC which is defined if either
CONFIG_PMAC or CONFIG_ALL_PPC are defined, so we can make stuff
conditional on that.

Paul.

--
Paul Mackerras, Senior Open Source Researcher, Linuxcare, Inc.
+61 2 6262 8990 tel, +61 2 6262 8991 fax
paulus@linuxcare.com.au, http://www.linuxcare.com.au/
Linuxcare.  Support for the revolution.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
