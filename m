Date: Sun, 3 Nov 2002 15:06:26 -0500
Subject: Re: Status of 2.5.X kernels on PPC Linux, anyone working with NPTL?
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v546)
Cc: David Edelsohn <dje@watson.ibm.com>,
	linuxppc-dev@lists.linuxppc.org,
	yellowdog-devel@lists.terrasoftsolutions.com
To: Aldy Hernandez <aldyh@redhat.com>
From: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
In-Reply-To: <20021103185509.GA2437@redhat.com>
Message-Id: <BB8D85EA-EF67-11D6-81A1-0003938E434C@ivey.uwo.ca>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

>> - missing support for small structure return values in register pairs
>> r3, r4
>
> I thought support for this already in place, but gcc had the wrong
> endianness in the registers.  If this is so, I already have a patch
> for this (not commited though ;-)).

According to my tests small structure returns in registers are not
currently being used for PPC Linux (32 bit) for gcc 3.2.1 and earlier
(and never have been AFAIK) but I can not speak for
the 3.3 tree and later.

Kevin


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
