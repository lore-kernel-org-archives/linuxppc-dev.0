Date: Wed, 9 Oct 2002 13:14:08 -0400
Subject: Re: Status of 2.5.X kernels on PPC Linux, anyone working with NPTL? 
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v482)
Cc: linuxppc-dev@lists.linuxppc.org,
	yellowdog-devel@lists.terrasoftsolutions.com
To: David Edelsohn <dje@watson.ibm.com>
From: Kevin Hendricks <khendricks@ivey.uwo.ca>
In-Reply-To: <200210091634.MAA28260@makai.watson.ibm.com>
Message-Id: <857DA0B4-DBAA-11D6-BCE2-0030654D6A26@ivey.uwo.ca>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi David,

Thanks for responding.

> 	There still is a question of what the final version of thread
> support will look like in Glibc.  TLS support has not been added to
> PowerPC GCC yet.  GPR 13 is reserved for the thread ID.  I do not know
> whether that also can be used as the TLS base pointer.
>
Is IBM's NGPT the alternative being considered or just changes in how
NPTL is being implemented?

I did not realize that two registers were needed (a thread id register
and a tls base pointer).
Are you and Geoff the people that will make the decision of which
registers will be allocated and when?

Thanks,

Kevin


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
