From: Paul Mackerras <paulus@linuxcare.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <14827.38371.822681.539244@argo.linuxcare.com.au>
Date: Tue, 17 Oct 2000 10:57:23 +1100 (EST)
To: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: pmac_power_off is gone in 2.2.17
In-Reply-To: <20001012175322.A5273@suse.de>
References: <20001012175322.A5273@suse.de>
Reply-To: paulus@linuxcare.com.au
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Olaf Hering writes:

> the pmac_power_off() call in pmac_halt() disappeared in 2.2.17.
> Is there any special reason for that? I affects proably only B&W
> machines, /sbin/halt doesnt work anymore.

This was changed to make it consistent with the behaviour on other
architectures.  Distributions should use halt -p in their init scripts
if power-off is required on shutdown.

Paul.

--
Paul Mackerras, Senior Open Source Researcher, Linuxcare, Inc.
+61 2 6262 8990 tel, +61 2 6262 8991 fax
paulus@linuxcare.com.au, http://www.linuxcare.com.au/
Linuxcare.  Support for the revolution.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
