Message-ID: <3CEA70AB.1070405@mvista.com>
Date: Tue, 21 May 2002 09:07:07 -0700
From: Armin Kuster <akuster@mvista.com>
MIME-Version: 1.0
To: Kenneth Johansson <kenneth.johansson@inn.ericsson.se>
Cc: Linuxppc embedded <linuxppc-embedded@lists.linuxppc.org>,
	andrew may <acmay@acmay.homeip.net>
Subject: Re: 405 I2C
References: <1021995053.7265.22.camel@swb11>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Kenneth Johansson wrote:
> How would you feel about merging the i2c-adap-ibm_ocp.c
> andi2c-algo-ibm_ocp.c into one file. This way it's possible to build the
> i2c drivers as a module.
>
>
> Also I have a problem when accessing a device that is not present. The
> bus ends up in busy state an no other action can be taken. I solved the
> problem for me here by simply removing the test in iix_xfer but a proper
> solution has to be discussed. I have not tried Andrew's new iic_xfer is
> it going to be merged ??
>
>
>

They should both work as modules as it stands, or at least it did in the
past.  IMHO is does not matter if it is one or two files. Andrew's
iic_xfer was bundled in with many other changes that did not fly, but I
would revisit is if a new patch where submitted with just the iic_xfer.

armin


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
