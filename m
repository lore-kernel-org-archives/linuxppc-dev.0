Message-ID: <3FCF3CE0.4020008@embeddededge.com>
Date: Thu, 04 Dec 2003 08:55:44 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Pantelis Antoniou <panto@intracom.gr>
Cc: Paul Mackerras <paulus@samba.org>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: the door is closing for 2.4
References: <16334.33020.624995.521330@cargo.ozlabs.ibm.com> <3FCEFB59.80300@intracom.gr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Pantelis Antoniou wrote:

> However I don't think that 2.6 works for 8xx at all.

It doesn't.

> What is the status of 2.6 for 8xx?

It's a f'ing mess.

> Does someone intent to do it, or should I try to give it a shot?

I intended to do it, but I'm so busy with non-PPC stuff I never
finshed much of anything.

Right now, it won't even compile because all of the drivers need
updates, then we need the usual processor dependent porting stuff
done.  I have a pretty good idea what needs to be done, it's just
more work than the few weekends I thought it would take.

If someone wants to get the drivers to compile, I'll continue working
on the processor specific parts and maybe we can get it done soon.

Thanks.



	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
