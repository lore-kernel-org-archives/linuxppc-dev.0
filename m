Message-ID: <3FCEFB59.80300@intracom.gr>
Date: Thu, 04 Dec 2003 11:16:09 +0200
From: Pantelis Antoniou <panto@intracom.gr>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: the door is closing for 2.4
References: <16334.33020.624995.521330@cargo.ozlabs.ibm.com>
In-Reply-To: <16334.33020.624995.521330@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Paul Mackerras wrote:

>Guys,
>
>Marcelo has announced that as of 2.4.25, the official 2.4 tree is
>going into maintenance-only mode.  There is still a lot of stuff in
>the linuxppc-2.4 and linuxppc_2_4_devel trees which hasn't gone into
>the official 2.4 tree.  Most of that is board ports for various
>embedded boards, and for many of those boards, it's not clear whether
>anyone cares whether they are supported by the official 2.4 or not.
>
>So if you have a board that you want to see supported by the official
>2.4 tree, and it isn't already, let me know.  I will need someone to
>commit to maintaining the port on an ongoing basis before I send it to
>Marcelo, though.
>
>We also need people to start moving their embedded board ports to
>2.6, along with all the related device drivers, etc.  We are already
>past the point where new development should all be done in 2.5/2.6.
>
>Paul.
>
Hi Paul

I have various boards based on 8xx that I want to get them in  but I can't
because they depend on some patches that I was told should wait for 2.6.

However I don't think that 2.6 works for 8xx at all.

What is the status of 2.6 for 8xx?

Does someone intent to do it, or should I try to give it a shot?

Regards

Pantelis


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
