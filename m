From: tom_gall@vnet.ibm.com
Message-ID: <398576E5.77C9E466@vnet.ibm.com>
Date: Mon, 31 Jul 2000 12:53:57 +0000
Reply-To: tom_gall@vnet.ibm.com
MIME-Version: 1.0
To: bob@kunk.jriver.com
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: RS/6000 Model 170 Boots Linux
References: <20000729203215.23597.qmail@kunk.jriver.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


bob@kunk.jriver.com wrote:
>
> I'm curious about a few things...
>
> The Power 3 in the 170 is running in 32 bit mode I assume?

Hi Bob,

That's correct. The 64 bit PowerPC Kernel is a work in progress at the moment.

> Also with reference to the PPC linux system running on the Beta Power 4
> is this also in 32 bit mode?

That is also correct.

> The Power 3,  RS6000-III and Power 4 are all 64 bit chips from what I
> understand and IBM's literature makes me think that AIX is indeed running
> in 64 bit mode with the ability to run 32 bit apps.

Actually the AIX kernel runs in 32 bit mode, however it has the ability to run
64 bit apps.

> >From what I have heard, NT running on the Alpha is in 32 bit mode. Is
> Linux running on the Alpha also 32 bit? I would assume Tru64 Unix is
> running in 64 bit mode on the Alpha....

Alpha Linux is 64 bit.

Regards,

Tom

--
Tom Gall - PowerPC Linux Team    "Where's the ka-boom? There was
Linux Technology Center           supposed to be an earth
(w) tom_gall@vnet.ibm.com         shattering ka-boom!"
(w) 507-253-4558                 -- Marvin Martian
(h) tgall@uswest.net
http://oss.software.ibm.com/developerworks/opensource/linux

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
