Message-ID: <3FD0D477.9000201@embeddededge.com>
Date: Fri, 05 Dec 2003 13:54:47 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Pantelis Antoniou <panto@intracom.gr>
Cc: Paul Mackerras <paulus@samba.org>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: the door is closing for 2.4
References: <16334.33020.624995.521330@cargo.ozlabs.ibm.com> <3FCEFB59.80300@intracom.gr> <3FCF3CE0.4020008@embeddededge.com> <3FCF4D78.9000706@intracom.gr> <3FCF540C.3010302@embeddededge.com> <3FD032C1.9060504@intracom.gr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Pantelis Antoniou wrote:

> Well if you can get head_8xx.S in some decent shape I can get it to boot
> since in a board of mine I don't use the built-in uart but an external
> MAX3100.

OK, I'll work on that.

> And finally do you think it makes sence to try to consolidate the 8xx
> and 82xx drivers?

We've had the disucssion in the past, and I don't think it is.  From a
very high level, they look similar, but there are lots of detailed
differences (like object alignments, 32-bit versus 16-bit fields with
the same names and purposes, and so on).  I think we would have files
filled with lots of #ifdefs and hard to read.  I would really like it
if someone would make compilimentary changes to both drivers, when
they are doing one of them, but that has never happened.  Usually one
driver is updated and I move the changes to the other, if applicable.
For 82xx and 85xx it makes sense to use the same drivers, and we are,
as the CPM is truly identical.  There are some mapping issues to work
out, but that is underway.  I'd like to get this done first, then
visit this 8xx/82xx discussion again.

Thanks.

	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
