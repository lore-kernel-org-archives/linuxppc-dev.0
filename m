Message-ID: <3D65C5A8.5010408@embeddededge.com>
Date: Fri, 23 Aug 2002 01:18:32 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: "Dr. Craig Hollabaugh" <craig@hollabaugh.com>
Cc: Marius Groeger <mag@sysgo.de>,
	John Fisher <John.Fisher@nec.com.au>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: cygwin and embedded linux
References: <000501c24979$6348a190$37d34c93@neca.nec.com.au> <3.0.3.32.20020822173918.006dbb00@hollabaugh.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dr. Craig Hollabaugh wrote:

> I'm curious ...
>
> How many out there actually are compiling PPC code natively on a PowerPC Linux box for their embedded devices?

Me.

> If so, do you run the same development versions on your desktop?

Almost :-)

> How do you handle the FPU issues?

For 4xx/8xx I'll use a cross compiler, all other PowerPCs have FPUs.
For embedded Altivecs I have to use the host compiler.

I do all of my development for all embedded processors on a PowerMac running YDL.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
