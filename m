Message-ID: <3FCF540C.3010302@embeddededge.com>
Date: Thu, 04 Dec 2003 10:34:36 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Pantelis Antoniou <panto@intracom.gr>
Cc: Paul Mackerras <paulus@samba.org>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: the door is closing for 2.4
References: <16334.33020.624995.521330@cargo.ozlabs.ibm.com> <3FCEFB59.80300@intracom.gr> <3FCF3CE0.4020008@embeddededge.com> <3FCF4D78.9000706@intracom.gr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Pantelis Antoniou wrote:

> Once upon a time I had it at least compile, but for my board only.
> But then you mentioned you were working on it and I dropped it.

I had been working on it, primarily to get the processor specific
changes done.

> Could you please elaborate on the tasks that need to be done?
> I know that the head_8xx.S file definetely needs alot of work,
> and you mentioned the drivers.

The serial driver doesn't compile since the serial subsystem was
reworked.  The old data structures used to represent port
information (in particular serial_state) no longer works.
Yes, head_8xx.S needs lots of work, but to me that is the easy part :-)


> What is the minimum stuff needed to make it work at least for my
> boards?

Make it compile again, I'll take it from there.

> I'd be happy to help at least as long as my busy schedule permits.

Me, too.  Just don't be annoyed if it takes me a while to respond,
especially if testing changes is involved.

Thanks.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
