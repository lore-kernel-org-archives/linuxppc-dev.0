Message-ID: <3E763B4D.8050107@mvista.com>
Date: Mon, 17 Mar 2003 13:17:01 -0800
From: Todd Poynor <tpoynor@mvista.com>
MIME-Version: 1.0
To: Felix Domke <tmbinc@elitedvb.net>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: IDE corruption w/ 48 Bit addressing
References: <3E74C280.3000608@elitedvb.net>
In-Reply-To: <3E74C280.3000608@elitedvb.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Felix Domke wrote:
>
> Hi,
>
> i'm having a PPC-405 based board (IBM STB04500 if anyone cares), and i'm
> using a Maxtor 6Y200L0, a 200GB harddisk drive.
>
> Obviously this uses 48bit addressing, and i'm using linucppc 2.4.21-pre4
> devel. The same bug occurs with 2.4.20 release.

So far as I know the IBM Redwood-5 (STB04xxx) has an ATAPI-5 controller
onboard, which would not support 48-bit addressing and would support a
max of 137GB.  But if you're using an ATA/6 controller then nevermind...


--
Todd


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
