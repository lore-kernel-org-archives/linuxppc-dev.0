Date: Tue, 16 May 2000 12:51:08 -0700
From: Tim Wojtulewicz <Tim.Wojtulewicz@NAU.EDU>
Subject: Re: Pismo status
In-reply-to: <20000516161545.A10347@lambda.u-strasbg.fr>
To: linuxppc-dev@lists.linuxppc.org, debian-powerpc@lists.debian.org
Message-id: <p04301801b54757188869@[209.147.134.138]>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
References: <20000516172313.A3581@freeonline.com.au>
 <39210AF3.4964C38A@relog.ch> <20000516161545.A10347@lambda.u-strasbg.fr>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>Isn't it supposed to have no fan ?
>
>

No it's definitely supposed to have a fan.  It comes on in MacOS.
The problem is that the PMU is not fully supported yet, so it doesn't
understand that the processor is too hot.  I'm trying to find
information about it, but I'm not having much luck.  If anything, try
running Paul's pmud (you can get it from rpmfind.net).  It helps a
little.

Tim

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
